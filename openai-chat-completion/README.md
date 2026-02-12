# OpenAI Chat Completion Run Job

A Xano Run Job that sends chat completion requests to the OpenAI API and returns structured responses with token usage information.

## What This Run Job Does

This run job demonstrates how to integrate with OpenAI's Chat Completions API from XanoScript. It:

1. Takes a user prompt as input
2. Sends it to OpenAI's `/v1/chat/completions` endpoint
3. Returns the AI-generated response along with metadata including:
   - The generated text response
   - Model used
   - Token usage statistics (prompt, completion, and total tokens)

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENAI_API_KEY` | Your OpenAI API key (required) |

Set this in your Xano workspace environment variables.

## How to Use

### Default Usage
The run job comes with a default prompt:
```xs
run.job "OpenAI Chat Completion" {
  main = {
    name: "openai_chat"
    input: {
      prompt: "Explain XanoScript in one sentence."
      model: "gpt-4o-mini"
      temperature: 0.7
      max_tokens: 150
    }
  }
  env = ["openai_api_key"]
}
```

### Custom Prompts
You can modify the `input` block in `run.xs` to use your own prompts:

```xs
input: {
  prompt: "Your custom prompt here"
  model: "gpt-4o"
  temperature: 0.5
  max_tokens: 1000
}
```

### Available Input Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `prompt` | text | (required) | The message to send to OpenAI |
| `model` | text | "gpt-4o-mini" | OpenAI model identifier |
| `temperature` | decimal | 0.7 | Controls randomness (0-2) |
| `max_tokens` | int | 500 | Maximum response length |

### Supported Models
- `gpt-4o` - Latest flagship model
- `gpt-4o-mini` - Fast, affordable model (default)
- `gpt-4-turbo` - Previous generation
- `gpt-3.5-turbo` - Legacy model

## File Structure

```
openai-chat-completion/
├── run.xs                      # Run job configuration
├── functions/
│   └── openai_chat.xs          # Main function that calls OpenAI API
└── README.md                   # This file
```

## Response Format

```json
{
  "success": true,
  "response": "XanoScript is a declarative scripting language for building backends in Xano.",
  "model": "gpt-4o-mini-2024-07-18",
  "usage": {
    "prompt_tokens": 15,
    "completion_tokens": 12,
    "total_tokens": 27
  },
  "prompt_tokens": 15,
  "completion_tokens": 12,
  "total_tokens": 27
}
```

## Error Handling

The function includes validation for:
- Missing `OPENAI_API_KEY` environment variable
- Empty or invalid API responses
- OpenAI API errors (passed through from the API)

## Notes

- The function always includes a system message: "You are a helpful assistant."
- Token usage is tracked for cost monitoring
- The API request is synchronous (not async)
