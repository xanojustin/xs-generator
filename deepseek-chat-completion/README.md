# DeepSeek Chat Completion - Xano Run Job

This Xano Run Job generates AI chat completions using the [DeepSeek](https://deepseek.com) API. DeepSeek offers powerful language models at competitive prices, including their general-purpose `deepseek-chat` model and the coding-specialized `deepseek-coder` model.

## What This Run Job Does

The `DeepSeek Chat Completion` run job sends messages to DeepSeek's AI models and returns generated responses:

1. Accepts a user message and optional parameters (model, temperature, max_tokens)
2. Makes an authenticated request to DeepSeek's `/v1/chat/completions` endpoint
3. Returns the AI-generated response along with usage statistics

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `deepseek_api_key` | Your DeepSeek API Key | `sk-xxxxxxxxxxxxxxxxxxxxxxxx` |

### Getting Your DeepSeek API Key

1. Sign up or log in to the [DeepSeek Platform](https://platform.deepseek.com)
2. Navigate to the API Keys section
3. Create a new API key
4. Copy and securely store the key (it won't be shown again)

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "DeepSeek Chat Completion"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "DeepSeek Chat Completion"
}
```

### Customizing the Request

Edit the `input` block in `run.xs`:

```xs
run.job "DeepSeek Chat Completion" {
  main = {
    name: "deepseek_chat_completion"
    input: {
      model: "deepseek-coder"           // Model: 'deepseek-chat' or 'deepseek-coder'
      message: "Write a Python function to reverse a string"
      temperature: 0.5                   // 0.0 = focused, 2.0 = creative
      max_tokens: 500                    // Maximum response length
    }
  }
  env = ["deepseek_api_key"]
}
```

### Available Models

| Model | Description | Best For |
|-------|-------------|----------|
| `deepseek-chat` | General-purpose conversational AI | General Q&A, writing, analysis |
| `deepseek-coder` | Code-specialized model | Programming, debugging, code review |

### Parameter Details

- **model**: Which DeepSeek model to use (`deepseek-chat` or `deepseek-coder`)
- **message**: The prompt or question to send to the AI
- **temperature**: Controls randomness (0.0 = deterministic, 2.0 = very random). Default: 0.7
- **max_tokens**: Maximum number of tokens to generate. Default: 1000

## File Structure

```
deepseek-chat-completion/
├── run.xs                              # Run job configuration
├── function/
│   └── deepseek_chat_completion.xs     # Function that calls DeepSeek API
└── README.md                           # This file
```

## Response Format

On success, the function returns:

```json
{
  "success": true,
  "content": "XanoScript is a declarative scripting language designed for building backend logic in Xano, a no-code/low-code platform.",
  "model": "deepseek-chat",
  "usage": {
    "prompt_tokens": 15,
    "completion_tokens": 25,
    "total_tokens": 40
  },
  "finish_reason": "stop"
}
```

### Response Fields

| Field | Description |
|-------|-------------|
| `success` | Boolean indicating if the request succeeded |
| `content` | The AI-generated response text |
| `model` | The model used for the completion |
| `usage.prompt_tokens` | Tokens used in the input message |
| `usage.completion_tokens` | Tokens used in the generated response |
| `usage.total_tokens` | Total tokens consumed |
| `finish_reason` | Why generation stopped (`stop`, `length`, etc.) |

## Error Handling

The function throws specific errors for different failure scenarios:

| Error Name | Cause |
|------------|-------|
| `DeepSeekAuthError` | Invalid or missing API key (HTTP 401) |
| `DeepSeekRateLimitError` | Rate limit exceeded (HTTP 429) |
| `DeepSeekClientError` | Bad request or client-side issue (HTTP 4xx) |
| `DeepSeekAPIError` | Server-side error from DeepSeek (HTTP 5xx) |

## Security Notes

- **Never commit your DeepSeek API key** - always use environment variables
- Store API keys securely in Xano's environment variable settings
- Consider implementing request rate limiting to control costs
- Monitor your DeepSeek dashboard for usage and billing

## Pricing Considerations

DeepSeek offers competitive pricing compared to other AI providers:
- Check the [DeepSeek Pricing Page](https://platform.deepseek.com/pricing) for current rates
- Use the `usage` field in responses to track token consumption
- Set appropriate `max_tokens` limits to control costs

## Additional Resources

- [DeepSeek API Documentation](https://platform.deepseek.com/docs)
- [DeepSeek Pricing](https://platform.deepseek.com/pricing)
- [XanoScript Documentation](https://docs.xano.com)
