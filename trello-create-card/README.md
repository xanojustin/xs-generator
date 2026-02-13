# Trello Create Card Run Job

A XanoScript run job that creates a new card in a Trello board list.

## What It Does

This run job creates a Trello card with:
- **Card Name** - The title of the card
- **Card Description** - Optional detailed description (supports Markdown)
- **Due Date** - Optional due date in ISO 8601 format
- **Labels** - Optional comma-separated list of label IDs

Perfect for:
- Creating tasks from form submissions
- Adding feature requests to product backlogs
- Logging support tickets
- Automating project management workflows

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `trello_api_key` | Your Trello API Key |
| `trello_api_token` | Your Trello API Token |

### How to Get Your Trello Credentials

1. **API Key**: Go to https://trello.com/app-key while logged in
2. **API Token**: On that same page, click the "Token" link to generate a token

## How to Use

### 1. Set the Environment Variables

```bash
export trello_api_key="your_api_key_here"
export trello_api_token="your_api_token_here"
```

### 2. Find Your List ID

To get a list ID:
1. Open the Trello board in your browser
2. Look at the URL: `https://trello.com/b/XXXXXX/board-name`
3. Make a GET request to: `https://api.trello.com/1/boards/XXXXXX/lists?key=YOUR_KEY&token=YOUR_TOKEN`
4. Find your list and copy its `id` field

Or use the Xano Run Job with a board ID to list all lists first.

### 3. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

### 4. Customize the Card

Edit the `input` block in `run.xs` to customize:

```xs
run.job "Trello Create Card" {
  main = {
    name: "trello_create_card"
    input: {
      list_id: "64abc123def456"
      card_name: "Fix login bug"
      card_description: "Users are reporting issues with OAuth login on mobile devices."
      due_date: "2025-12-31T23:59:59.000Z"
      labels: "red_label_id,green_label_id"
    }
  }
  env = ["trello_api_key", "trello_api_token"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `list_id` | text | Yes | The Trello list ID where the card will be created |
| `card_name` | text | Yes | The title/name of the card |
| `card_description` | text | No | Detailed description (Markdown supported) |
| `due_date` | text | No | Due date in ISO 8601 format (e.g., `2025-12-31T23:59:59.000Z`) |
| `labels` | text | No | Comma-separated list of label IDs to apply |

### Finding Label IDs

To get label IDs for a board:
```
GET https://api.trello.com/1/boards/{board_id}/labels?key=YOUR_KEY&token=YOUR_TOKEN
```

## File Structure

```
trello-create-card/
├── run.xs                              # Run job configuration
├── functions/
│   └── trello_create_card.xs           # Function that calls Trello API
└── README.md                           # This file
```

## API Reference

This implementation uses the Trello REST API:

### Create Card
- Endpoint: `POST https://api.trello.com/1/cards`
- Documentation: https://developer.atlassian.com/cloud/trello/rest/api-group-cards/#api-cards-post

### Authentication
Trello uses API Key + Token authentication passed as query parameters.

## Response

On success, the function returns:

```json
{
  "success": true,
  "card_id": "64abc123def456ghi789",
  "card_url": "https://trello.com/c/AbCdEfGh",
  "card_name": "Fix login bug",
  "list_id": "64abc123def456",
  "board_id": "64xyz789abc123",
  "created_at": "2025-02-13T08:30:00.000Z"
}
```

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing required fields (list_id, card_name)
- Invalid Trello API credentials
- Non-existent list IDs
- Invalid due date formats
- Rate limiting errors

## Example Use Cases

### 1. Bug Reporting Form
```xs
input: {
  list_id: "bugs_list_id"
  card_name: "Bug Report: " ~ $input.bug_title
  card_description: "Reported by: " ~ $input.reporter_email ~ "\n\n" ~ $input.bug_description
}
```

### 2. Feature Requests
```xs
input: {
  list_id: "feature_requests_list_id"
  card_name: $input.feature_title
  card_description: "Requested by: " ~ $input.customer_name ~ "\n\nPriority: " ~ $input.priority
  labels: "label_id_for_new_feature"
}
```

### 3. Task Scheduling
```xs
input: {
  list_id: $input.project_list_id
  card_name: $input.task_name
  due_date: $input.deadline
  card_description: "Assigned to: " ~ $input.assignee
}
```

## License

MIT
