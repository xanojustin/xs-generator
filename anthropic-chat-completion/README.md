# Anthropic Claude Chat Completion

This Xano Run Job sends chat completion requests to the Anthropic Claude API.

## What It Does

The run job calls the Anthropic Claude API to generate AI responses using Claude's powerful language models. It supports:

- Multiple Claude models (Claude 3 Sonnet, Opus, Haiku)
- Customizable system prompts
- Conversation history with messages array
- Temperature control for response creativity
- Token limit configuration

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `ANTHROPIC_API_KEY` | Your Anthropic API key (required) |

Get your API key from: https://console.anthropic.com/

## Input Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `model` | text | `claude-3-sonnet-20240229` | Claude model to use |
| `system` | text | (optional) | System prompt to set behavior |
| `messages` | object[] | (required) | Array of message objects with `role` and `content` |
| `temperature` | decimal | `0.7` | Creativity (0.0 = deterministic, 1.0 = creative) |
| `max_tokens` | int | `1024` | Maximum tokens to generate |

## Message Format

```json
[
  {
    "role": "user",
    "content": "Hello, Claude!"
  }
]
```

**Supported roles:** `user`, `assistant`

## Response Format

```json
{
  "success": true,
  "model": "claude-3-sonnet-20240229",
  "content": "Hello! Here's a fun fact about AI...",
  "usage": {
    "input_tokens": 15,
    "output_tokens": 150
  },
  "stop_reason": "end_turn",
  "id": "msg_01XXXXXXXXXXXXXXXXXXXXXX"
}
```

## Available Models

- `claude-3-opus-20240229` - Most powerful, best for complex tasks
- `claude-3-sonnet-20240229` - Balanced performance and speed (default)
- `claude-3-haiku-20240307` - Fastest, most cost-effective

## How to Use

1. Set your `ANTHROPIC_API_KEY` environment variable in Xano
2. Deploy this run job to the Xano Job Runner
3. The job will execute with the default prompt, or customize the input parameters

## Example Usage

```xanoscript
run.job "My Claude Request" {
  main = {
    name: "anthropic_chat_completion"
    input: {
      model: "claude-3-opus-20240229"
      system: "You are a helpful coding assistant."
      messages: [
        {
          role: "user"
          content: "Write a Python function to calculate fibonacci numbers."
        }
      ]
      temperature: 0.3
      max_tokens: 2048
    }
  }
  env = ["ANTHROPIC_API_KEY"]
}
```

## API Reference

- Anthropic API Docs: https://docs.anthropic.com/claude/reference/messages_post
- Model Pricing: https://www.anthropic.com/pricing

## Folder Structure

```
anthropic-chat-completion/
├── README.md                              # This file
├── run.xs                                 # Run job configuration
└── function/
    └── anthropic_chat_completion.xs       # Main function implementation
```
