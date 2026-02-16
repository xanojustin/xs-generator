# Groq Chat Completion Run Job

A Xano Run Job that sends chat completion requests to the Groq API for ultra-fast AI inference.

## What It Does

This run job demonstrates how to use Groq's API to get fast responses from popular open-source LLMs like Llama, Mixtral, and Gemma. Groq is known for its blazing-fast inference speeds (up to 18x faster than competitors).

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `GROQ_API_KEY` | Your Groq API key (get one at https://console.groq.com) |

## How to Use

### Running the Job

```bash
# From the project directory
xano run run.xs
```

### Customizing the Input

Edit the `input` block in `run.xs`:

```xs
run.job "Groq Chat Completion" {
  main = {
    name: "groq_chat_completion"
    input: {
      model: "mixtral-8x7b-32768",      // Change model
      message: "Your custom prompt here", // Your message
      temperature: 0.5,                   // Adjust creativity (0-2)
      max_tokens: 512                     // Max response length
    }
  }
  env = ["GROQ_API_KEY"]
}
```

### Available Models

- `llama-3.3-70b-versatile` - Meta's Llama 3.3 70B (default)
- `mixtral-8x7b-32768` - Mistral's Mixtral 8x7B
- `gemma-7b-it` - Google's Gemma 7B
- `llama-3.1-8b-instant` - Meta's Llama 3.1 8B (fastest)

### Response Format

```json
{
  "success": true,
  "model": "llama-3.3-70b-versatile",
  "message": "Groq's inference engine is so fast because...",
  "usage": {
    "prompt_tokens": 25,
    "completion_tokens": 50,
    "total_tokens": 75
  }
}
```

## File Structure

```
groq-chat-completion/
├── run.xs                          # Run job configuration
├── function/
│   └── groq_chat_completion.xs    # Main function
└── README.md                       # This file
```

## API Reference

- Groq Docs: https://console.groq.com/docs
- Groq Console: https://console.groq.com
