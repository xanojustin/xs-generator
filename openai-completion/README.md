# OpenAI Completion Run Job

A Xano Run Job that generates AI-powered content using the OpenAI Chat Completions API. Perfect for adding AI capabilities to your applications.

## What It Does

This run job generates AI content using OpenAI's GPT models. It can be used for:

- Generating text content (articles, descriptions, summaries)
- Creating chatbot responses
- Code generation and explanation
- Content moderation and analysis
- Language translation
- Creative writing and brainstorming

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `OPENAI_API_KEY` | Your OpenAI API key | [OpenAI Platform](https://platform.openai.com/api-keys) → Create new secret key |

## How to Use

### 1. Set Up Environment Variables

Set this in your Xano workspace environment variables:

```
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 2. Run the Job

The run job executes the `generate_completion` function with the configured input parameters.

### 3. Customize the Input

Edit `run.xs` to change the generation parameters:

```xs
run.job "OpenAI Generate Content" {
  main = {
    name: "generate_completion"
    input: {
      prompt: "Write a product description for a wireless headphone"
      model: "gpt-4o-mini"
      max_tokens: 300
      temperature: 0.8
      system_message: "You are a professional copywriter specializing in e-commerce."
    }
  }
  env = ["OPENAI_API_KEY"]
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prompt` | text | Yes | - | The user prompt/instruction for the AI |
| `model` | text | No | `gpt-4o-mini` | OpenAI model ID (gpt-4o, gpt-4o-mini, etc.) |
| `max_tokens` | int | No | `150` | Maximum tokens to generate (1-4096) |
| `temperature` | decimal | No | `0.7` | Sampling temperature (0-2, higher = more random) |
| `system_message` | text | No | - | System instructions to guide AI behavior |

## Available Models

| Model | Description | Use Case |
|-------|-------------|----------|
| `gpt-4o` | Most capable multimodal model | Complex reasoning, creative tasks |
| `gpt-4o-mini` | Fast, affordable, capable | Most everyday tasks |
| `gpt-4-turbo` | High intelligence | Complex analysis, coding |
| `gpt-3.5-turbo` | Fast and cost-effective | Simple tasks, high volume |

## Response

On success, the function returns:

```json
{
  "success": true,
  "content": "The generated AI response text goes here...",
  "model": "gpt-4o-mini",
  "prompt_tokens": 12,
  "completion_tokens": 45,
  "total_tokens": 57,
  "finish_reason": "stop"
}
```

## Error Handling

The function validates inputs and environment variables before making the API call. Common errors:

- **Missing API key**: Ensure `OPENAI_API_KEY` is set
- **Invalid model**: Use a valid OpenAI model ID
- **Rate limiting**: Too many requests; implement retry logic
- **Token limit exceeded**: Reduce `max_tokens` or shorten prompt
- **Invalid temperature**: Must be between 0 and 2

## File Structure

```
openai-completion/
├── run.xs                        # Run job definition
├── function/
│   └── generate_completion.xs    # AI completion function
└── README.md                     # This file
```

## API Reference

- [OpenAI Chat Completions API](https://platform.openai.com/docs/api-reference/chat)
- [OpenAI Models](https://platform.openai.com/docs/models)
- [OpenAI Pricing](https://openai.com/pricing)

## Example Use Cases

### Generate Product Descriptions

```xs
input: {
  prompt: "Write a compelling product description for noise-canceling headphones"
  model: "gpt-4o-mini"
  max_tokens: 200
  temperature: 0.8
  system_message: "You are an expert e-commerce copywriter."
}
```

### Code Explanation

```xs
input: {
  prompt: "Explain what this code does: function fib(n) { return n <= 1 ? n : fib(n-1) + fib(n-2); }"
  model: "gpt-4o"
  max_tokens: 250
  temperature: 0.3
}
```

### Creative Writing

```xs
input: {
  prompt: "Write a short story about a robot learning to paint"
  model: "gpt-4o"
  max_tokens: 500
  temperature: 1.0
  system_message: "You are a creative writing assistant."
}
```

### Customer Support Response

```xs
input: {
  prompt: "Draft a polite response to a customer asking about delayed shipping"
  model: "gpt-4o-mini"
  max_tokens: 150
  temperature: 0.5
  system_message: "You are a helpful customer support representative."
}
```

## Testing

Test with a simple prompt:

```xs
run.job "Test OpenAI" {
  main = {
    name: "generate_completion"
    input: {
      prompt: "Say hello world in a creative way"
      model: "gpt-4o-mini"
      max_tokens: 50
    }
  }
  env = ["OPENAI_API_KEY"]
}
```

## Notes

- Costs are based on token usage (input + output)
- GPT-4o-mini is recommended for most use cases due to cost-effectiveness
- Set `temperature` lower (0.1-0.3) for factual responses, higher (0.8-1.0) for creative tasks
- Use `system_message` to define the AI's role and constraints
- Consider implementing response caching for repeated prompts
