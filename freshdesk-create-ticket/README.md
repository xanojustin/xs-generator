# Freshdesk Create Ticket

This XanoScript run job creates support tickets in Freshdesk via their REST API.

## What This Run Job Does

Creates a new support ticket in your Freshdesk account with customizable subject, description, priority, status, and tags.

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `FRESHDESK_API_KEY` | Your Freshdesk API key | `AbCdEfGhIjKlMnOpQrSt` |
| `FRESHDESK_DOMAIN` | Your Freshdesk domain (without .freshdesk.com) | `yourcompany` |

### Getting Your Freshdesk API Key

1. Log in to your Freshdesk account
2. Click your profile picture in the top right
3. Go to "Profile Settings"
4. Your API key will be in the right sidebar under "Your API Key"

## Usage

### Basic Usage (Default Input)

```bash
xano run
```

This will create a ticket with the default values specified in `run.xs`.

### Custom Input via API

You can also trigger this run job via the Xano Run API with custom parameters:

```json
{
  "subject": "Billing Question",
  "description": "I have a question about my recent invoice.",
  "email": "customer@example.com",
  "name": "John Doe",
  "priority": 2,
  "status": 2,
  "tags": ["billing", "urgent"]
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `subject` | text | Yes | - | Ticket subject line |
| `description` | text | Yes | - | Ticket description/body (HTML supported) |
| `email` | text | Yes | - | Requester email address |
| `name` | text | No | "Xano User" | Requester name |
| `priority` | int | No | 1 | Priority: 1=Low, 2=Medium, 3=High, 4=Urgent |
| `status` | int | No | 2 | Status: 2=Open, 3=Pending, 4=Resolved, 5=Closed |
| `source` | text | No | "2" | Source: 1=Email, 2=Portal, 3=Phone, 7=Chat, 9=Feedback Widget |
| `tags` | text[] | No | - | Array of tags to apply to the ticket |

## Response

```json
{
  "success": true,
  "ticket_id": 12345,
  "ticket_url": "https://yourcompany.freshdesk.com/a/tickets/12345",
  "created_at": "2024-01-15T10:30:00Z",
  "error": null
}
```

## Error Handling

The function validates:
- Environment variables are configured
- Required fields (subject, description, email) are provided
- API response status

Returns detailed error messages if the Freshdesk API returns an error.

## Freshdesk API Reference

- [Freshdesk API v2 Documentation](https://developers.freshdesk.com/api/)
- [Create Ticket Endpoint](https://developers.freshdesk.com/api/#create_ticket)

## File Structure

```
freshdesk-create-ticket/
├── run.xs              # Run job configuration
├── function/
│   └── create_ticket.xs  # Ticket creation function
└── README.md           # This file
```
