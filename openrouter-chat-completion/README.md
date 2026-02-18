# OpenRouter Chat Completion Run Job

A Xano Run Job that integrates with the [OpenRouter](https://openrouter.ai/) API to generate AI chat completions using various LLM models.

## What This Run Job Does

This run job calls the OpenRouter API to send a message to an AI model and receive a chat completion response. OpenRouter provides a unified interface to access multiple AI models including Claude, GPT-4, Gemini, and many others.

### Features

- **Multi-Model Support**: Use any model available on OpenRouter (Claude, GPT-4, Gemini, etc.)
- **Error Handling**: Comprehensive error handling for auth failures, rate limits, and API errors
- **Usage Tracking**: Returns token usage information in the response
- **Configurable**: Specify the model and message via input parameters

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `OPENROUTER_API_KEY` | Your OpenRouter API key | Yes |

Get your API key at: https://openrouter.ai/keys

## How to Use

### Basic Usage

The run job is configured to run with default values:

```bash
# Set your API key
export OPENROUTER_API_KEY="your-api-key-here"

# Run the job
xano run
```

### Customizing the Input

Edit the `run.xs` file to change the model or message:

```xs
run.job "OpenRouter Chat Completion" {
  main = {
    name: "call_openrouter_chat"
    input: {
      model: "openai/gpt-4o"                    // Change to any OpenRouter model
      message: "What is the capital of France?" // Your custom message
    }
  }
  env = ["OPENROUTER_API_KEY"]
}
```

### Available Models

Popular models available on OpenRouter:

- `anthropic/claude-3.5-sonnet` - Claude 3.5 Sonnet
- `anthropic/claude-3-opus` - Claude 3 Opus
- `openai/gpt-4o` - GPT-4o
- `openai/gpt-4o-mini` - GPT-4o Mini
- `google/gemini-1.5-pro` - Gemini 1.5 Pro
- `meta-llama/llama-3.1-70b-instruct` - Llama 3.1 70B
- `mistralai/mistral-large` - Mistral Large

See all models at: https://openrouter.ai/models

## Response Format

On success, the function returns:

```json
{
  "success": true,
  "model": "anthropic/claude-3.5-sonnet",
  "message": "I'm doing well, thank you for asking! How can I help you today?",
  "usage": {
    "prompt_tokens": 15,
    "completion_tokens": 23,
    "total_tokens": 38
  }
}
```

## Error Handling

The run job handles the following error cases:

- **401 Unauthorized**: Invalid API key
- **429 Rate Limit**: Too many requests
- **Other errors**: API errors with detailed messages

## File Structure

```
openrouter-chat-completion/
├── run.xs                           # Run job configuration
├── function/
│   └── call_openrouter_chat.xs     # Main function implementation
└── README.md                        # This file
```

## API Reference

- **OpenRouter API Docs**: https://openrouter.ai/docs
- **Model List**: https://openrouter.ai/models

## License

MIT
