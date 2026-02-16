# Ollama Generate Completion

A Xano Run Job that generates text completions using a local Ollama instance.

## What it does

This run job connects to a local Ollama server and generates AI text completions using any model you have pulled (llama3.2, mistral, codellama, etc.). It:

1. Sends a prompt to the Ollama `/api/generate` endpoint
2. Streams back the generated response
3. Logs the generation metadata (timing, token counts) to a database table
4. Returns the completion with performance metrics

## Prerequisites

1. [Ollama](https://ollama.com) installed and running locally (or on a remote server)
2. At least one model pulled (e.g., `ollama pull llama3.2`)

## Required Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `OLLAMA_BASE_URL` | Base URL of your Ollama server | `http://localhost:11434` |

## How to use

### Basic usage

The run job executes the `ollama_generate` function with default parameters:
- Model: `llama3.2`
- Prompt: `What is the capital of France?`

### Custom parameters

Modify the `input` object in `run.xs`:

```xs
run.job "Ollama Generate Completion" {
  main = {
    name: "ollama_generate"
    input: {
      model: "codellama"
      prompt: "Write a Python function to calculate fibonacci numbers"
      stream: false
    }
  }
  env = ["OLLAMA_BASE_URL"]
}
```

### Input parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `model` | text | Yes | The Ollama model to use (e.g., `llama3.2`, `mistral`, `codellama`) |
| `prompt` | text | Yes | The prompt text to send to the model |
| `stream` | boolean | No | Whether to stream the response (default: `false`) |

### Response format

```json
{
  "success": true,
  "model": "llama3.2",
  "response": "The capital of France is Paris.",
  "done": true,
  "timing": {
    "total_duration_ms": 1250.5,
    "load_duration_ms": 45.2,
    "prompt_eval_count": 8,
    "eval_count": 12
  },
  "log_id": 1
}
```

## Files

| File | Purpose |
|------|---------|
| `run.xs` | Run job configuration |
| `function/ollama_generate.xs` | Main function that calls Ollama API |
| `table/generation_log.xs` | Table for logging generation history |

## Ollama API Reference

- Docs: https://github.com/ollama/ollama/blob/main/docs/api.md
- Generate endpoint: `POST /api/generate`

## Common models

- `llama3.2` - Meta's Llama 3.2 (fast, capable)
- `mistral` - Mistral AI's 7B model
- `codellama` - Code-specialized Llama
- `phi3` - Microsoft's Phi-3
- `gemma2` - Google's Gemma 2
