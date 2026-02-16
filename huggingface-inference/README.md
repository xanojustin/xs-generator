# Hugging Face Inference Run Job

This XanoScript run job runs ML inference using the Hugging Face Inference API.

## What It Does

This run job sends text to Hugging Face's Inference API to run machine learning models for:

- **Zero-shot classification** - Classify text into custom categories without training
- **Sentiment analysis** - Determine if text is positive, negative, or neutral
- **Text classification** - Categorize text using pre-trained models
- **Named entity recognition** - Extract entities like names, dates, locations
- **Feature extraction** - Generate embeddings for similarity search
- **Question answering** - Answer questions based on context
- **And more** - Any model from Hugging Face's model hub

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `HUGGINGFACE_API_KEY` | Your Hugging Face API token (from huggingface.co/settings/tokens) |

## How to Use

### Run the Job

The job is configured with a zero-shot classification example in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `model` | text | Yes | Hugging Face model ID (e.g., `facebook/bart-large-mnli`) |
| `text` | text | Yes | Input text to analyze/classify |
| `candidate_labels` | list | No | Labels for zero-shot classification |
| `wait_for_model` | boolean | No | Wait if model is loading (default: `true`) |

### Popular Models

**Classification:**
- `facebook/bart-large-mnli` - Zero-shot classification (default)
- `distilbert-base-uncased-finetuned-sst-2-english` - Sentiment analysis
- `cardiffnlp/twitter-roberta-base-sentiment-latest` - Twitter sentiment

**Named Entity Recognition:**
- `dslim/bert-base-NER` - General NER
- `Jean-Baptiste/roberta-large-ner-english` - English NER

**Feature Extraction:**
- `sentence-transformers/all-MiniLM-L6-v2` - Text embeddings
- `sentence-transformers/all-mpnet-base-v2` - Better quality embeddings

**Question Answering:**
- `deepset/roberta-base-squad2` - Reading comprehension
- `distilbert-base-cased-distilled-squad` - Lightweight QA

### Response Format

**Zero-shot Classification:**
```json
{
  "success": true,
  "result": [
    {"label": "technology", "score": 0.9845},
    {"label": "food", "score": 0.0087},
    {"label": "sports", "score": 0.0045},
    {"label": "politics", "score": 0.0023}
  ],
  "is_classification": true,
  "model": "facebook/bart-large-mnli",
  "error": null
}
```

**Sentiment Analysis:**
```json
{
  "success": true,
  "result": [
    {"label": "POSITIVE", "score": 0.9987},
    {"label": "NEGATIVE", "score": 0.0013}
  ],
  "is_classification": true,
  "model": "distilbert-base-uncased-finetuned-sst-2-english",
  "error": null
}
```

**Error Response:**
```json
{
  "success": false,
  "result": null,
  "is_classification": false,
  "model": "facebook/bart-large-mnli",
  "error": "Model is currently loading. Estimated time: 15 seconds. Try again shortly."
}
```

## File Structure

```
huggingface-inference/
├── run.xs                         # Run job definition
├── function/
│   └── run_inference.xs           # Function to call Hugging Face API
└── README.md                      # This file
```

## Hugging Face API Reference

- [Inference API Docs](https://huggingface.co/docs/api-inference/index)
- [Model Hub](https://huggingface.co/models)
- [API Token Settings](https://huggingface.co/settings/tokens)

## Pricing

Hugging Face offers:
- **Free tier** - Rate limited, shared resources
- **Pro tier** - Higher rate limits, faster inference
- **Enterprise** - Dedicated infrastructure

Most models run for free with rate limits. Check the [pricing page](https://huggingface.co/pricing) for details.

## Security Notes

- Never commit your `HUGGINGFACE_API_KEY` to version control
- Use environment variables or a secrets manager for production
- Consider implementing caching to reduce API calls
- Monitor your API usage in the Hugging Face dashboard

## Example Use Cases

- **Content moderation** - Classify user-generated content
- **Support ticket routing** - Route tickets by category
- **Sentiment monitoring** - Track brand sentiment
- **Document classification** - Organize documents automatically
- **Intent detection** - Understand user intent in chatbots
- **Entity extraction** - Pull structured data from text
