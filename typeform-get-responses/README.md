# Typeform Get Responses

This Xano Run Job fetches responses from a Typeform form using the Typeform API.

## What It Does

Retrieves survey/form submissions from Typeform, including:
- Response data with answers to each question
- Metadata like submission time, completion status
- Respondent information (if collected)

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `TYPEFORM_API_KEY` | Your Typeform API access token (get from https://admin.typeform.com/account#/section/token) |

## How to Use

### Find Your Form ID

1. Open your form in Typeform
2. Look at the URL: `https://admin.typeform.com/form/ABC123/` 
3. The form ID is the part after `/form/` (e.g., `ABC123`)

### Run the Job

The job is configured with these default inputs:

```json
{
  "form_id": "your-form-id-here",
  "page_size": "10"
}
```

### Optional Parameters

| Parameter | Description | Example |
|-----------|-------------|---------|
| `page_size` | Number of responses (1-1000) | `"50"` |
| `since` | Responses after this date | `"2024-01-01T00:00:00Z"` |
| `until` | Responses before this date | `"2024-12-31T23:59:59Z"` |
| `completed` | Filter by status | `"true"` or `"false"` |

## Response Format

```json
{
  "success": true,
  "total_items": 42,
  "responses": [
    {
      "response_id": "abc123",
      "submitted_at": "2024-01-15T10:30:00Z",
      "completed": true,
      "answers": [...]
    }
  ],
  "error": null
}
```

## API Documentation

https://developer.typeform.com/responses/
