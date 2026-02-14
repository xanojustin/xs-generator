# Trello Create Card Run Job

This XanoScript run job creates a new card on a Trello board using the Trello REST API.

## What It Does

This run job creates a Trello card with the following capabilities:

- Create a card with a name and optional description
- Assign the card to a specific list on a board
- Set an optional due date
- Returns the card ID, URL, and other metadata
- Handles errors gracefully with descriptive messages

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `TRELLO_API_KEY` | Your Trello API key (get from https://trello.com/app-key) |
| `TRELLO_TOKEN` | Your Trello API token (generate from the same page) |

## How to Get Your Trello Credentials

1. Go to https://trello.com/app-key while logged into Trello
2. Copy your **Key** - this is your `TRELLO_API_KEY`
3. Click the "Token" link to generate a **Token** - this is your `TRELLO_TOKEN`
4. To get a List ID:
   - Open a Trello board in your browser
   - Add `.json` to the end of the board URL (e.g., `https://trello.com/b/xxxxxx/boardname.json`)
   - Search for `"idList"` or look under `lists` array
   - Or use the Trello API: `GET /1/boards/{board_id}/lists`

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | text | Yes | The name/title of the card |
| `description` | text | No | The description/body of the card (supports Markdown) |
| `list_id` | text | Yes | The Trello list ID where the card should be created |
| `due_date` | text | No | Due date in ISO 8601 format (e.g., `2026-02-20T17:00:00.000Z`) |
| `label_ids` | text | No | Comma-separated list of label IDs to attach to the card |
| `member_ids` | text | No | Comma-separated list of member IDs to assign to the card |

### Response

```json
{
  "success": true,
  "card_id": "65abc123def4567890123456",
  "card_url": "https://trello.com/c/xxxxxxxx",
  "card_name": "New Task from Xano",
  "board_id": "65abc123def4567890123457",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "card_id": null,
  "card_url": null,
  "card_name": null,
  "board_id": null,
  "error": "invalid id"
}
```

## File Structure

```
trello-create-card/
├── run.xs                    # Run job definition
├── function/
│   └── create_card.xs        # Function to create Trello card
└── README.md                 # This file
```

## Trello API Reference

- [Cards API Documentation](https://developer.atlassian.com/cloud/trello/rest/api-group-cards/#api-cards-post)
- [Getting Started with Trello API](https://developer.atlassian.com/cloud/trello/guides/rest-api/getting-started/)

## Example Usage

### Create a simple card:
```
name: "Review Q1 Report"
list_id: "5f3a2b1c4d5e6f7g8h9i0j1k"
```

### Create a card with description and due date:
```
name: "Deploy to Production"
description: "## Deployment Checklist\n- [ ] Run tests\n- [ ] Update changelog"
list_id: "5f3a2b1c4d5e6f7g8h9i0j1k"
due_date: "2026-02-20T17:00:00.000Z"
```

## Security Notes

- Never commit your `TRELLO_API_KEY` or `TRELLO_TOKEN` to version control
- Use environment variables for all credentials
- Consider using a dedicated Trello account/API key for automated integrations
- The token provides access to all boards the user has access to - keep it secure
