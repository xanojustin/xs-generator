# Trello Create Card - Xano Run Job

This Xano Run Job creates a new card on a Trello board using the Trello REST API.

## What It Does

This run job allows you to programmatically create cards on Trello boards with support for:
- Card name and description
- Optional due dates
- Optional labels
- Full error handling and validation

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `trello_api_key` | Your Trello API Key | https://trello.com/app-key |
| `trello_api_token` | Your Trello API Token | Generated from the same page above |

## How to Use

### 1. Set Up Environment Variables

Add the following to your Xano workspace environment variables:
- `trello_api_key` - Your Trello API key
- `trello_api_token` - Your Trello API token

### 2. Get Your List ID

To create a card, you need the ID of the list where the card should be created:

1. Open Trello in your browser
2. Navigate to the board and list where you want to create cards
3. Add `.json` to the end of the board URL (e.g., `https://trello.com/b/XXXX/board-name.json`)
4. Find the `lists` array and copy the `id` of your target list

Alternatively, use the Trello API to list all lists on a board:
```
GET https://api.trello.com/1/boards/{boardId}/lists?key={apiKey}&token={apiToken}
```

### 3. Configure Input Parameters

Edit `run.xs` to set your desired inputs:

```xs
run.job "Create Trello Card" {
  main = {
    name: "create_trello_card"
    input: {
      list_id: "YOUR_LIST_ID_HERE"
      card_name: "My New Card"
      card_description: "Description of the card"
    }
  }
  env = ["trello_api_key", "trello_api_token"]
}
```

### 4. Run the Job

Use the Xano CLI to run the job:
```bash
xano run execute ./run.xs
```

Or use the Xano Run API to execute it remotely.

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `list_id` | text | Yes | The ID of the Trello list to add the card to |
| `card_name` | text | Yes | The name/title of the card |
| `card_description` | text | No | The description/body of the card |
| `card_due_date` | text | No | Due date in ISO 8601 format (e.g., "2024-12-31T23:59:59.000Z") |
| `card_labels` | text[] | No | Array of label IDs to apply to the card |

## Response

On success, the function returns:

```json
{
  "success": true,
  "card_id": "65abc123def456",
  "card_url": "https://trello.com/c/XXXXXX/1-card-name",
  "card_name": "My New Card",
  "board_id": "65abc123def789",
  "list_id": "65abc123def012"
}
```

## File Structure

```
trello-create-card/
├── README.md          # This file
├── run.xs            # Run job configuration
└── function/
    └── create_trello_card.xs  # Main function implementation
```

## API Reference

This run job uses the Trello REST API:
- Documentation: https://developer.atlassian.com/cloud/trello/rest/api-group-cards/#api-cards-post
- Endpoint: `POST /1/cards`

## Error Handling

The function includes comprehensive error handling:
- Validates that required environment variables are set
- Checks for successful API response (200/201 status)
- Returns meaningful error messages for debugging

## Example Use Cases

- Create cards from customer support tickets
- Add tasks from form submissions
- Automated project management workflows
- Integration with external systems for task creation
