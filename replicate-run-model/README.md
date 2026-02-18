# Replicate Run AI Model

A Xano Run Job that runs AI model predictions using the [Replicate](https://replicate.com) API. This job creates a prediction, optionally waits for completion, and returns the results.

## What It Does

This run job:
1. Creates a prediction on Replicate using any public or private model
2. Optionally polls for completion until the prediction finishes
3. Returns the prediction results including output URLs/data

## Use Cases

- Generate images using FLUX, Stable Diffusion, or other image models
- Run text generation with Llama, Mistral, or other LLMs
- Process audio with Whisper, MusicGen, or other audio models
- Run any model hosted on Replicate's platform

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `REPLICATE_API_TOKEN` | Your Replicate API token (get from https://replicate.com/account/api-tokens) |

## How to Use

### Basic Usage

The run job is configured in `run.xs` to run FLUX Schnell with a default prompt:

```xs
run.job "Replicate Run AI Model" {
  main = {
    name: "replicate_run_prediction"
    input: {
      model: "black-forest-labs/flux-schnell"
      input_data: {
        prompt: "A serene mountain landscape at sunset with a lake reflection"
        aspect_ratio: "16:9"
        output_format: "webp"
        output_quality: 80
      }
      wait_for_completion: true
      poll_interval: 1
      max_poll_attempts: 60
    }
  }
  env = ["REPLICATE_API_TOKEN"]
}
```

### Customizing the Model

Change the `model` parameter to use different models:

```xs
// Image generation with SDXL
model: "stability-ai/sdxl"

// Text generation with Llama
model: "meta/llama-2-70b-chat"

// Audio with MusicGen
model: "facebook/musicgen"
```

### Model-Specific Input Data

Each model accepts different input parameters. Check the model's page on Replicate for the exact schema. Examples:

**FLUX Schnell:**
```xs
input_data: {
  prompt: "A cyberpunk city at night with neon lights"
  aspect_ratio: "16:9"
  output_format: "webp"
  output_quality: 90
}
```

**Llama 2:**
```xs
input_data: {
  prompt: "Explain quantum computing in simple terms"
  max_tokens: 500
  temperature: 0.7
}
```

### Polling Options

| Parameter | Default | Description |
|-----------|---------|-------------|
| `wait_for_completion` | `true` | If false, returns immediately after creating the prediction |
| `poll_interval` | `1` | Seconds between status checks |
| `max_poll_attempts` | `60` | Maximum polling attempts before timeout |

### Response Format

```json
{
  "prediction_id": "xyz123",
  "status": "succeeded",
  "model": "black-forest-labs/flux-schnell",
  "input": { "prompt": "...", "aspect_ratio": "..." },
  "output": "https://replicate.delivery/.../image.webp",
  "error": null,
  "created_at": "2024-01-15T10:30:00Z",
  "completed_at": "2024-01-15T10:30:05Z",
  "urls": {
    "get": "https://api.replicate.com/v1/predictions/xyz123",
    "cancel": "https://api.replicate.com/v1/predictions/xyz123/cancel"
  },
  "metrics": {
    "predict_time": 4.5
  }
}
```

## API Reference

- [Replicate API Docs](https://replicate.com/docs/reference/http)
- [Replicate Model Library](https://replicate.com/explore)

## Folder Structure

```
replicate-run-model/
├── run.xs                          # Run job configuration
├── function/
│   └── replicate_run_prediction.xs # Main function
└── README.md                       # This file
```
