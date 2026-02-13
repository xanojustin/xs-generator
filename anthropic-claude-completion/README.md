# Anthropic Claude Completion - Xano Run Job

A Xano Run Job that sends completion requests to the Anthropic Claude API and returns AI-generated responses.

## What It Does

This run job integrates with Anthropic's Claude API to generate AI text completions. It supports:

- Multiple Claude models (Claude 3.5 Sonnet, Claude 3 Opus, Claude 3 Haiku)
- Configurable max tokens, temperature, and system prompts
- Detailed token usage tracking
- Error handling with meaningful error messages

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `anthropic_api_key` | Your Anthropic API key (starts with `sk-ant-`) |

Get your API key from: https://console.anthropic.com/settings/keys

## How to Use

### As a Run Job

The job runs the `claude_completion` function with default parameters:

```xs
run.job "Anthropic Claude Completion" {
  main = {
    name: "claude_completion"
    input: {
      prompt: "Explain XanoScript in one sentence."
      model: "claude-3-5-sonnet-20241022"
      max_tokens: 500
      temperature: 0.7
    }
  }
  env = ["anthropic_api_key"]
}
```

### Function Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prompt` | text | Yes | - | The user message to send to Claude |
| `model` | text | No | `claude-3-5-sonnet-20241022` | Claude model to use |
| `max_tokens` | int | No | 1024 | Maximum tokens in response (1-8192) |
| `temperature` | decimal | No | 0.7 | Sampling temperature (0-1) |
| `system_prompt` | text | No | See default | System prompt to guide behavior |

### Available Models

- `claude-3-5-sonnet-20241022` - Best balance of intelligence and speed (default)
- `claude-3-opus-20240229` - Most powerful, best for complex tasks
- `claude-3-haiku-20240307` - Fastest, most cost-effective

### Response Format

```json
{
  "success": true,
  "response": "XanoScript is a declarative scripting language...",
  "model": "claude-3-5-sonnet-20241022",
  "usage": {
    "input_tokens": 15,
    "output_tokens": 42
  },
  "input_tokens": 15,
  "output_tokens": 42
}
```

## File Structure

```
anthropic-claude-completion/
├── run.xs                          # Run job configuration
├── functions/
│   └── claude_completion.xs        # Main function
└── README.md                       # This file
```

## Example: Custom Prompt

To run with a custom prompt, modify the `input` block in `run.xs`:

```xs
input: {
  prompt: "Write a Python function to calculate fibonacci numbers"
  model: "claude-3-opus-20240229"
  max_tokens: 2000
  temperature: 0.5
  system_prompt: "You are an expert Python developer. Provide clean, well-documented code."
}
```

## Error Handling

The function validates:
- API key presence
- HTTP response status
- Content availability in response

Errors are thrown with descriptive messages for debugging.

## API Reference

This integration uses the Anthropic Messages API:
- Endpoint: `https://api.anthropic.com/v1/messages`
- Documentation: https://docs.anthropic.com/en/api/messages

## Rate Limits

Anthropic API rate limits vary by plan:
- Free tier: Limited requests per minute
- Paid tiers: Higher limits based on usage tier

Check your limits at: https://console.anthropic.com/settings/plan

## Security Notes

- Never commit your API key to version control
- Use Xano environment variables for secure key storage
- Rotate keys regularly in the Anthropic console
