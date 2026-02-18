# OpenAI Generate Completion - Xano Run Job

This Xano Run Job generates text completions using the [OpenAI](https://openai.com) Chat Completions API and logs the requests and responses to a database table.

## What It Does

1. Accepts a prompt and optional parameters (model, max_tokens, temperature)
2. Calls OpenAI's `/v1/chat/completions` API
3. Logs the request and response details to the `completion_log` table
4. Returns the generated completion text along with token usage

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENAI_API_KEY` | Your OpenAI API key (get from https://platform.openai.com/api-keys) |

## How to Use

### Run the Job

```bash
# Using the Xano CLI
xano run --job "OpenAI Generate Completion"
```

### Customize Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "OpenAI Generate Completion" {
  main = {
    name: "generate_completion"
    input: {
      prompt: "Explain quantum computing in simple terms"
      model: "gpt-4o"
      max_tokens: 500
      temperature: 0.5
    }
  }
  env = ["OPENAI_API_KEY"]
}
```

### Function Inputs

The `generate_completion` function accepts:

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `prompt` | text | Yes | - | The prompt/message to send to OpenAI |
| `model` | text | No | "gpt-4o-mini" | OpenAI model to use (e.g., gpt-4o, gpt-4o-mini) |
| `max_tokens` | int | No | 150 | Maximum number of tokens to generate |
| `temperature` | decimal | No | 0.7 | Sampling temperature (0-2, lower = more focused) |

### Response

```json
{
  "success": true,
  "completion": "Programming is both art and science...",
  "model": "gpt-4o-mini-2024-07-18",
  "usage": {
    "prompt_tokens": 7,
    "completion_tokens": 20,
    "total_tokens": 27
  },
  "log_id": 1
}
```

### Error Response

If the OpenAI API returns an error:

```json
{
  "name": "OpenAIError",
  "value": "OpenAI API error: Invalid API key"
}
```

## Files

- `run.xs` - Run job configuration
- `function/generate_completion.xs` - OpenAI API integration logic
- `table/completion_log.xs` - Database table for logging completions

## Notes

- This uses the Chat Completions API (not the legacy Completions API)
- All requests are logged including failed ones
- Token usage is tracked for cost monitoring
- Use a test API key for development
- Consider implementing rate limiting for production use
- The default model is `gpt-4o-mini` for cost-effectiveness
