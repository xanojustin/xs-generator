# OpenAI Content Moderation Run Job

A Xano run job that uses OpenAI's Moderation API to check text content for harmful categories including hate, harassment, self-harm, sexual content, and violence.

## What It Does

This run job sends text to OpenAI's moderation endpoint and returns:
- Whether the content is flagged as harmful
- Breakdown of flagged categories (hate, harassment, self-harm, sexual, violence, etc.)
- Confidence scores for each category
- Maximum score across all categories

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `openai_api_key` | Your OpenAI API key |

## How to Use

### Run with Default Input

```bash
# Execute the run job with default sample text
xano run execute ./run.xs
```

### Run with Custom Text

Override the input text to check your own content:

```bash
xano run execute ./run.xs --input '{"text": "Your content here"}'
```

### Example Response

```json
{
  "flagged": true,
  "categories": {
    "harassment": true,
    "harassment_threatening": false,
    "hate": false,
    "hate_threatening": false,
    "self_harm": false,
    "self_harm_instructions": false,
    "sexual": false,
    "sexual_minors": false,
    "violence": false,
    "violence_graphic": false
  },
  "category_scores": {
    "harassment": 0.85,
    ...
  },
  "max_score": 0.85,
  "model": "omni-moderation-latest",
  "checked_at": "2025-02-12T12:15:00Z"
}
```

## File Structure

```
openai-moderation/
├── run.xs              # Run job configuration
├── functions/
│   └── moderate_content.xs  # Moderation function
└── README.md           # This file
```

## API Reference

Uses the [OpenAI Moderations API](https://platform.openai.com/docs/api-reference/moderations):

- **Endpoint**: `POST https://api.openai.com/v1/moderations`
- **Model**: `omni-moderation-latest` (default, supports text and image)

## Use Cases

- Content filtering for user-generated content
- Pre-publication review systems
- Automated community moderation
- Safety checks for chatbot responses
