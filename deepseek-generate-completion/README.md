# DeepSeek Generate Completion

A Xano Run Job that generates text completions using the DeepSeek AI API.

## What It Does

This run job calls the DeepSeek API to generate AI-powered text completions. It sends a user prompt to DeepSeek's chat completions endpoint and returns the generated response along with token usage information.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `deepseek_api_key` | Your DeepSeek API key (get one at https://platform.deepseek.com) |

## How to Use

### Running the Job

The run job is configured in `run.xs`. By default, it sends a sample prompt about quantum computing. You can modify the input parameters in the run job configuration:

```xs
run.job "DeepSeek Generate Completion" {
  main = {
    name: "generate_completion"
    input: {
      prompt: "Your custom prompt here"
      model: "deepseek-chat"
      temperature: 0.7
      max_tokens: 1024
    }
  }
  env = ["deepseek_api_key"]
}
```

### Function Parameters

The `generate_completion` function accepts the following inputs:

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prompt` | text | Yes | - | The user prompt to send to DeepSeek |
| `model` | text | No | `deepseek-chat` | Model to use (e.g., `deepseek-chat`, `deepseek-reasoner`) |
| `temperature` | decimal | No | `0.7` | Sampling temperature (0.0 to 2.0) |
| `max_tokens` | int | No | `1024` | Maximum number of tokens to generate |

### Response

The function returns an object with:

```json
{
  "completion": "The generated text response...",
  "model": "deepseek-chat",
  "usage": {
    "prompt_tokens": 25,
    "completion_tokens": 150,
    "total_tokens": 175
  },
  "success": true
}
```

## Files

- `run.xs` - Run job configuration
- `function/generate_completion.xs` - Function that calls the DeepSeek API

## API Reference

This integration uses the DeepSeek Chat Completions API:
- Endpoint: `https://api.deepseek.com/chat/completions`
- Documentation: https://platform.deepseek.com/docs

## Example Use Cases

- Generate blog post content
- Create code explanations
- Answer user questions
- Summarize text
- Draft email responses
- Generate creative writing
