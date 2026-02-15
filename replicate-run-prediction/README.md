# Replicate Run Prediction Run Job

This XanoScript run job creates a prediction on a Replicate AI model. Replicate is a platform that lets you run machine learning models in the cloud without managing infrastructure.

## What It Does

This run job creates an asynchronous prediction on any Replicate model (like image generators, text models, audio processors, etc.). It handles:

- Creating a prediction with the specified model and input
- Passing prompts/inputs to the model
- Optional webhook notifications when the prediction completes
- Returning the prediction ID and initial status

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `REPLICATE_API_TOKEN` | Your Replicate API token (get from https://replicate.com/account/api-tokens) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `model` | text | Yes | Replicate model identifier (e.g., `black-forest-labs/flux-schnell`, `meta/meta-llama-3-8b-instruct`) |
| `prompt` | text | Yes | Input prompt for the model (format depends on the model) |
| `webhook_url` | text | No | URL to receive POST notification when prediction completes |

### Response

```json
{
  "success": true,
  "prediction_id": "xyz123abc",
  "status": "starting",
  "output": null,
  "urls": {
    "get": "https://api.replicate.com/v1/predictions/xyz123abc",
    "cancel": "https://api.replicate.com/v1/predictions/xyz123abc/cancel"
  },
  "logs": null,
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "prediction_id": null,
  "status": null,
  "output": null,
  "urls": null,
  "logs": null,
  "error": "Replicate API error: HTTP 401"
}
```

## File Structure

```
replicate-run-prediction/
├── run.xs                    # Run job definition
├── function/
│   └── run_prediction.xs     # Function to create prediction
├── README.md                 # This file
└── FEEDBACK.md               # Development feedback
```

## Popular Replicate Models

- **Image Generation:**
  - `black-forest-labs/flux-schnell` - Fast image generation (default)
  - `black-forest-labs/flux-dev` - Higher quality images
  - `stability-ai/stable-diffusion-3` - Stable Diffusion 3

- **Text/LLM:**
  - `meta/meta-llama-3-8b-instruct` - Llama 3 8B
  - `meta/meta-llama-3-70b-instruct` - Llama 3 70B

- **Audio:**
  - `openai/whisper` - Speech-to-text
  - `suno-ai/bark` - Text-to-speech

## Checking Prediction Status

Since predictions run asynchronously, you can check the status by making a GET request to:
```
https://api.replicate.com/v1/predictions/{prediction_id}
```

With header:
```
Authorization: Token {REPLICATE_API_TOKEN}
```

## Webhook Notifications

If you provide a `webhook_url`, Replicate will POST to that URL when the prediction completes. The webhook payload includes the full prediction result.

## Security Notes

- Never commit your `REPLICATE_API_TOKEN` to version control
- Use webhook signatures to verify webhook authenticity
- Model inputs may be logged by Replicate - don't send sensitive data

## Replicate API Reference

- [Replicate API Docs](https://replicate.com/docs/reference/http)
- [Model Explorer](https://replicate.com/explore)
