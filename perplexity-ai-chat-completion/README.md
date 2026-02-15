# Perplexity AI Chat Completion

A Xano Run Job that integrates with the Perplexity AI API to perform AI-powered chat completions with real-time web search capabilities.

## What It Does

This run job sends prompts to Perplexity AI and returns intelligent responses based on real-time web search. Perplexity AI is particularly useful for:

- Getting up-to-date information (unlike static LLMs with knowledge cutoffs)
- Research queries with cited sources
- Fact-checking with web-based evidence
- Current events and trending topics

## Features

- ✅ Real-time web search integration
- ✅ Optional citation support (links to sources)
- ✅ Multiple model support (sonar, sonar-pro, sonar-reasoning)
- ✅ Usage tracking (tokens consumed)
- ✅ Error handling and validation

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `perplexity_api_key` | Your Perplexity API key from [perplexity.ai/settings/api](https://perplexity.ai/settings/api) |

## How to Use

### Basic Usage

```bash
# Set your API key as an environment variable
export perplexity_api_key="your-api-key-here"

# Run the job
xano run ./run.xs
```

### With Custom Input

You can override the default inputs by passing them to the function:

```xs
run.job "Custom Perplexity Query" {
  main = {
    name: "perplexity_chat_completion"
    input: {
      prompt: "What are the top news stories today?"
      model: "sonar-pro"
      include_citations: true
    }
  }
  env = ["perplexity_api_key"]
}
```

## Available Models

| Model | Description | Best For |
|-------|-------------|----------|
| `sonar` | Lightweight, cost-effective | Simple queries, quick answers |
| `sonar-pro` | Advanced capabilities | Complex reasoning, detailed responses |
| `sonar-reasoning` | Enhanced reasoning | Multi-step problems, analysis |

## Response Format

```json
{
  "success": true,
  "model": "sonar",
  "content": "The response text from Perplexity AI...",
  "citations": [
    "https://example.com/source1",
    "https://example.com/source2"
  ],
  "usage": {
    "prompt_tokens": 15,
    "completion_tokens": 150,
    "total_tokens": 165
  }
}
```

## Error Handling

The function handles common error cases:

- Missing API key (returns clear error message)
- API request failures (returns status code and error details)
- Invalid responses (throws structured error)

## File Structure

```
perplexity-ai-chat-completion/
├── run.xs                              # Run job configuration
├── function/
│   └── perplexity_chat_completion.xs   # Main function logic
└── README.md                           # This file
```

## Resources

- [Perplexity AI Documentation](https://docs.perplexity.ai/)
- [Perplexity API Reference](https://docs.perplexity.ai/reference/post_chat_completions)
- [Get API Key](https://perplexity.ai/settings/api)

## License

MIT
