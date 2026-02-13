# OpenAI Chat Completion Run Job

This XanoScript run job generates AI chat completions using the OpenAI API.

## What It Does

This run job sends prompts to OpenAI's GPT models and returns AI-generated responses. It handles:

- Sending user prompts to OpenAI's chat completions API
- Supporting custom system messages to control AI behavior
- Configurable model selection (GPT-4, GPT-4o-mini, etc.)
- Temperature and max_tokens control for response tuning
- Returning completion text along with token usage statistics
- Proper error handling for API failures

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENAI_API_KEY` | Your OpenAI API key (starts with `sk-`) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `prompt` | text | Yes | The user's message/prompt to send to the AI |
| `model` | text | No | OpenAI model to use (default: `gpt-4o-mini`) |
| `system_message` | text | No | System message to set AI behavior/context |
| `temperature` | number | No | Sampling temperature 0-2 (default: `0.7`) |
| `max_tokens` | number | No | Maximum tokens to generate (default: `1000`) |

### Available Models

- `gpt-4o` - Most capable multimodal model
- `gpt-4o-mini` - Fast, affordable model (default)
- `gpt-4` - High-intelligence model
- `gpt-3.5-turbo` - Fast, cost-effective model

### Response

```json
{
  "success": true,
  "completion": "XanoScript is a declarative scripting language...",
  "usage": {
    "prompt_tokens": 15,
    "completion_tokens": 150,
    "total_tokens": 165
  },
  "finish_reason": "stop",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "completion": null,
  "usage": null,
  "finish_reason": null,
  "error": "Invalid API key provided"
}
```

## File Structure

```
openai-chat-completion/
├── run.xs                         # Run job definition
├── function/
│   └── chat_completion.xs         # Function to call OpenAI API
└── README.md                      # This file
```

## OpenAI API Reference

- [Chat Completions API](https://platform.openai.com/docs/api-reference/chat)
- [Models Overview](https://platform.openai.com/docs/models)

## Pricing

OpenAI charges based on token usage. Check the [OpenAI pricing page](https://openai.com/pricing) for current rates.

## Security Notes

- Never commit your `OPENAI_API_KEY` to version control
- Use environment variables or a secrets manager for production
- Consider implementing rate limiting to control costs
- Monitor your API usage in the OpenAI dashboard

## Example Use Cases

- Generate product descriptions
- Create chatbot responses
- Summarize text content
- Answer customer questions
- Generate code snippets
- Translate languages
