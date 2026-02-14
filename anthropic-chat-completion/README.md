# Anthropic Claude Chat Completion Run Job

This XanoScript run job generates chat completions using Anthropic's Claude API.

## What It Does

This run job sends messages to Claude, Anthropic's AI assistant, and returns the generated response. It handles:

- Sending user prompts to Claude
- Supporting system messages to customize behavior
- Configurable model selection (Claude 3.5 Sonnet, Claude 3 Opus, Claude 3 Haiku)
- Token usage tracking
- Error handling and response parsing

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `ANTHROPIC_API_KEY` | Your Anthropic API key (starts with `sk-ant-`) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `prompt` | text | Yes | The user's message/prompt to send to Claude |
| `model` | text | No | Claude model to use (default: `claude-3-5-sonnet-20241022`) |
| `system_message` | text | No | Optional system message to set Claude's behavior |
| `max_tokens` | text | No | Maximum tokens to generate (default: `1000`) |
| `temperature` | text | No | Sampling temperature 0-1 (default: `0.7`) |

### Available Models

- `claude-3-5-sonnet-20241022` - Most intelligent model (default)
- `claude-3-opus-20240229` - Most capable for complex tasks
- `claude-3-sonnet-20240229` - Balance of intelligence and speed
- `claude-3-haiku-20240307` - Fastest model for lightweight actions

### Response

```json
{
  "success": true,
  "completion": "XanoScript is a declarative scripting language...",
  "message_id": "msg_01Xxxxxxxxxxxxxxxxx",
  "model": "claude-3-5-sonnet-20241022",
  "usage": {
    "input_tokens": 25,
    "output_tokens": 150
  },
  "stop_reason": "end_turn",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "completion": null,
  "message_id": null,
  "model": null,
  "usage": null,
  "stop_reason": null,
  "error": "Invalid API key"
}
```

## File Structure

```
anthropic-chat-completion/
├── run.xs                          # Run job definition
├── function/
│   └── chat_completion.xs          # Function to call Claude API
└── README.md                       # This file
```

## Anthropic API Reference

- [Messages API](https://docs.anthropic.com/en/api/messages)
- [Model Comparison](https://docs.anthropic.com/en/docs/models-overview)
- [API Errors](https://docs.anthropic.com/en/api/errors)

## Security Notes

- Never commit your `ANTHROPIC_API_KEY` to version control
- Use environment-specific API keys for different deployments
- Monitor your API usage in the Anthropic console
- Set appropriate rate limits for your use case