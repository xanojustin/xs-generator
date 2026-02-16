# Anthropic Chat Completion - Xano Run Job

This Xano Run Job sends chat completion requests to the Anthropic Claude API. It demonstrates how to integrate with Anthropic's AI models from Xano.

## What This Run Job Does

The `Anthropic Chat Completion` run job:
1. Accepts conversation messages, model selection, and generation parameters
2. Makes an authenticated request to Anthropic's `/v1/messages` endpoint
3. Returns Claude's response with generated text, token usage, and stop reason

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `anthropic_api_key` | Your Anthropic API Key | `sk-ant-api03-...` |

### Getting Your Anthropic API Key

1. Log in to your [Anthropic Console](https://console.anthropic.com)
2. Go to Settings → API Keys
3. Click "Create Key" and copy your API key (starts with `sk-ant-api03-`)

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Anthropic Chat Completion"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Anthropic Chat Completion"
}
```

### Customizing the Request

Edit the `input` block in `run.xs`:

```xs
run.job "Anthropic Chat Completion" {
  main = {
    name: "anthropic_chat"
    input: {
      model: "claude-3-opus-20240229"  // Model to use
      max_tokens: 2048                   // Maximum response length
      messages: [
        {role: "user", content: "Your question here"}
      ]
      system: "You are a helpful assistant"  // Optional system prompt
      temperature: 0.7  // Optional: 0.0-1.0 (lower = more deterministic)
    }
  }
  env = ["anthropic_api_key"]
}
```

### Available Models

- `claude-3-5-sonnet-20241022` - Fast, capable (default)
- `claude-3-opus-20240229` - Most powerful
- `claude-3-haiku-20240307` - Fastest, most cost-effective

### Message Format

Messages should be an array of objects with `role` and `content`:

```json
[
  {"role": "user", "content": "Hello!"},
  {"role": "assistant", "content": "Hi there! How can I help?"},
  {"role": "user", "content": "What's the weather like?"}
]
```

Valid roles: `user`, `assistant`

## File Structure

```
anthropic-chat-completion/
├── run.xs                    # Run job configuration
├── function/
│   └── anthropic_chat.xs     # Function that calls Anthropic API
└── README.md                 # This file
```

## Response Format

On success, the function returns an Anthropic Message object:

```json
{
  "id": "msg_01X9...",
  "type": "message",
  "role": "assistant",
  "model": "claude-3-5-sonnet-20241022",
  "content": [
    {
      "type": "text",
      "text": "XanoScript is Xano's declarative scripting language for building backend logic without traditional code."
    }
  ],
  "stop_reason": "end_turn",
  "stop_sequence": null,
  "usage": {
    "input_tokens": 15,
    "output_tokens": 23
  }
}
```

### Response Fields

| Field | Description |
|-------|-------------|
| `id` | Unique message ID |
| `content` | Array of content blocks (text, etc.) |
| `content[0].text` | The generated response text |
| `stop_reason` | Why generation stopped (`end_turn`, `max_tokens`, `stop_sequence`) |
| `usage.input_tokens` | Number of input tokens used |
| `usage.output_tokens` | Number of output tokens generated |

## Error Handling

The function throws an `AnthropicAPIError` if:
- The API returns a non-2xx status code
- The request times out (after 60 seconds)
- Authentication fails (invalid API key)
- Rate limits are exceeded

Common error codes:
- `401` - Invalid API key
- `429` - Rate limit exceeded
- `400` - Invalid request (check your message format)

## Security Notes

- **Never commit your Anthropic API key** - always use environment variables
- Keep your API key secure and rotate it regularly
- Use the `system` parameter responsibly - don't include sensitive data
- Consider implementing retry logic for rate limit (429) errors
- Monitor your token usage to control costs

## Pricing

Anthropic charges based on token usage:
- Input tokens: Counted from your messages
- Output tokens: Counted from Claude's responses

Check [Anthropic's pricing page](https://www.anthropic.com/pricing) for current rates.

## Additional Resources

- [Anthropic API Documentation](https://docs.anthropic.com/claude/reference/getting-started-with-the-api)
- [Anthropic Console](https://console.anthropic.com)
- [XanoScript Documentation](https://docs.xano.com)
