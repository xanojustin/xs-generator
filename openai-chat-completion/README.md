# OpenAI Chat Completion Run Job

A XanoScript run job that sends chat completion requests to the OpenAI API.

## What It Does

This run job demonstrates how to integrate with the OpenAI API to generate AI-powered chat responses. It sends a conversation to OpenAI's GPT models and returns the assistant's response along with metadata like token usage.

## Features

- Send chat completion requests to OpenAI API
- Configurable model (defaults to GPT-4o)
- Adjustable temperature and max_tokens parameters
- Returns full response including content, usage stats, and finish reason
- Environment variable validation
- Error handling for API failures

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENAI_API_KEY` | Your OpenAI API key (get one at https://platform.openai.com/api-keys) |

## Usage

### As a Run Job

```bash
cd ~/xs/openai-chat-completion
xano run
```

### Customizing the Input

Edit the `input` block in `run.xs` to change the conversation:

```xs
run.job "OpenAI Chat Completion" {
  main = {
    name: "openai_chat_completion"
    input: {
      model: "gpt-4o-mini"        // Change model
      messages: [
        {
          role: "system"
          content: "You are a coding expert."
        }
        {
          role: "user"
          content: "Explain recursion in Python."
        }
      ]
      temperature: 0.5            // 0-2, lower = more focused
      max_tokens: 500             // Max response length
    }
  }
  env = ["OPENAI_API_KEY"]
}
```

### Calling the Function Directly

```xs
function.run "openai_chat_completion" {
  input = {
    model: "gpt-4o"
    messages: [
      { role: "system", content: "You are a helpful assistant." }
      { role: "user", content: "What is XanoScript?" }
    ]
    temperature: 0.7
    max_tokens: 200
  }
} as $result
```

## Response Format

```json
{
  "success": true,
  "model": "gpt-4o",
  "content": "The assistant's response text...",
  "usage": {
    "prompt_tokens": 25,
    "completion_tokens": 50,
    "total_tokens": 75
  },
  "finish_reason": "stop"
}
```

## File Structure

```
openai-chat-completion/
├── run.xs                          # Run job definition
├── function/
│   └── openai_chat_completion.xs   # Main function
└── README.md                       # This file
```

## Learn More

- [OpenAI API Documentation](https://platform.openai.com/docs)
- [OpenAI Chat Completions API](https://platform.openai.com/docs/api-reference/chat)
