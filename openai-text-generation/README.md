# OpenAI Text Generation Run Job

A Xano Run Job that generates text using OpenAI's GPT models via the Chat Completions API.

## What It Does

This run job generates creative text content by calling the OpenAI API with a customizable prompt. It demonstrates:
- External API integration with OpenAI
- Error handling for various HTTP status codes
- Structured input/output with optional parameters
- Environment variable usage for API keys

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `OPENAI_API_KEY` | Your OpenAI API key from https://platform.openai.com/api-keys | Yes |

## Usage

### Default Run
```bash
# Set your OpenAI API key
export OPENAI_API_KEY="sk-..."

# Run the job
xano job run openai-text-generation/
```

### Customizing the Prompt

Edit the `input` block in `run.xs`:

```xs
run.job "OpenAI Text Generation" {
  main = {
    name: "openai_generate_text"
    input: {
      prompt: "Your custom prompt here"
      model: "gpt-4o"  // or gpt-4o-mini, gpt-3.5-turbo
      max_tokens: 500
      temperature: 0.9
    }
  }
  env = ["OPENAI_API_KEY"]
}
```

### Available Models

- `gpt-4o` - Most capable multimodal model
- `gpt-4o-mini` - Fast, affordable model (default)
- `gpt-3.5-turbo` - Legacy fast model

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `prompt` | text | (required) | The text prompt to send to OpenAI |
| `model` | text | gpt-4o-mini | The OpenAI model to use |
| `max_tokens` | int | 150 | Maximum tokens in the response |
| `temperature` | decimal | 0.7 | Creativity level (0.0-2.0) |

## Output

The function returns a JSON object:

```json
{
  "success": true,
  "generated_text": "The generated response from OpenAI...",
  "model": "gpt-4o-mini",
  "prompt": "Your original prompt",
  "usage": {
    "prompt_tokens": 20,
    "completion_tokens": 50,
    "total_tokens": 70
  },
  "created_at": "2025-02-16T10:15:00Z"
}
```

## Error Handling

The job handles common error cases:
- **401** - Invalid or missing API key
- **429** - Rate limit exceeded
- **Other errors** - Returns detailed error message

## Files

| File | Purpose |
|------|---------|
| `run.xs` | Run job configuration |
| `function/openai_generate_text.xs` | Main function that calls OpenAI API |
| `README.md` | This documentation |
| `FEEDBACK.md` | MCP/XanoScript feedback for improvements |

## API Reference

- [OpenAI Chat Completions API](https://platform.openai.com/docs/api-reference/chat/create)
- [XanoScript Functions](https://docs.xano.com/xanoscript/functions)
- [Xano Run Jobs](https://docs.xano.com/xanoscript/run)