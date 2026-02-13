# Groq Chat Completion Run Job

This Xano Run Job sends chat completion requests to the Groq API for ultra-fast AI inference using open-source LLMs.

## What It Does

The run job executes a function that:
1. Sends a message to Groq's chat completions API
2. Uses Llama 3.3 70B Versatile (or your specified model)
3. Returns the AI-generated response with usage stats

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `groq_api_key` | Your Groq API key (get one at https://console.groq.com) |

## How to Use

### Run with Default Settings

The job runs with a default message:
```
"Explain the benefits of fast AI inference in one sentence."
```

### Customize the Input

Modify `run.xs` to change the model or message:

```xs
run.job "Groq Chat Completion" {
  main = {
    name: "groq_chat_completion"
    input: {
      model: "mixtral-8x7b-32768"  // Change model
      message: "Your custom prompt here"  // Change message
    }
  }
  env = ["groq_api_key"]
}
```

### Available Models

- `llama-3.3-70b-versatile` - Meta's Llama 3.3 70B (default)
- `mixtral-8x7b-32768` - Mistral's Mixtral 8x7B
- `llama-3.1-8b-instant` - Faster, smaller Llama model
- `gemma-7b-it` - Google's Gemma 7B

See https://console.groq.com/docs/models for the full list.

## Response Format

```json
{
  "content": "The generated AI response text...",
  "model": "llama-3.3-70b-versatile",
  "usage": {
    "prompt_tokens": 15,
    "completion_tokens": 25,
    "total_tokens": 40
  },
  "id": "chatcmpl-abc123",
  "created": 1707350400
}
```

## File Structure

```
groq-chat-completion/
├── run.xs                      # Run job configuration
├── function/
│   └── groq_chat_completion.xs # Function that calls Groq API
└── README.md                   # This file
```

## API Reference

- Groq API Docs: https://console.groq.com/docs/quickstart
- OpenAI-compatible endpoints
