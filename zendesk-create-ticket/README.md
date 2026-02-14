# Zendesk Create Ticket Run Job

This XanoScript run job creates a support ticket in Zendesk via the Tickets API.

## What It Does

This run job creates a Zendesk support ticket with the following features:

- Creates a ticket with subject, body, and priority
- Sets the requester name and email
- Supports adding tags for categorization
- Returns the created ticket ID, URL, and status
- Handles errors gracefully with descriptive messages

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `ZENDESK_SUBDOMAIN` | Your Zendesk subdomain (e.g., `yourcompany` for `yourcompany.zendesk.com`) |
| `ZENDESK_API_TOKEN` | Your Zendesk API token (generated in Admin → Channels → API) |
| `ZENDESK_API_EMAIL` | Email address of the Zendesk agent/admin making the request |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `subject` | text | Yes | The subject line of the ticket |
| `body` | text | Yes | The body/description of the ticket |
| `priority` | text | No | Priority level: `urgent`, `high`, `normal`, `low` (default: `normal`) |
| `requester_name` | text | No | Name of the person submitting the ticket |
| `requester_email` | text | Yes | Email address of the requester |
| `tags` | text | No | Comma-separated list of tags (e.g., `bug,urgent,payment`) |

### Response

```json
{
  "success": true,
  "ticket_id": 12345,
  "ticket_url": "https://yourcompany.zendesk.com/api/v2/tickets/12345.json",
  "status": "open",
  "created_at": "2024-01-15T10:30:00Z",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "ticket_id": null,
  "ticket_url": null,
  "status": null,
  "created_at": null,
  "error": "Invalid credentials - Authentication failed"
}
```

## File Structure

```
zendesk-create-ticket/
├── run.xs                    # Run job definition
├── function/
│   └── create_ticket.xs      # Function to create Zendesk ticket
└── README.md                 # This file
```

## Zendesk API Reference

- [Tickets API](https://developer.zendesk.com/api-reference/ticketing/tickets/tickets/)
- [Creating Tickets](https://developer.zendesk.com/api-reference/ticketing/tickets/tickets/#create-ticket)
- [API Authentication](https://developer.zendesk.com/api-reference/introduction/security-and-auth/)

## Setting Up Zendesk API Access

1. Go to **Admin Center** → **Apps and integrations** → **APIs** → **Zendesk API**
2. Enable **Token Access**
3. Click the **+** button to add a new token
4. Copy the token immediately (it won't be shown again)
5. Set your environment variables:
   - `ZENDESK_SUBDOMAIN`: Your subdomain (the part before `.zendesk.com`)
   - `ZENDESK_API_TOKEN`: The token you just created
   - `ZENDESK_API_EMAIL`: Your admin/agent email address

## Priority Levels

- `urgent` - Requires immediate attention
- `high` - Should be addressed quickly
- `normal` - Standard priority (default)
- `low` - Can be addressed when time permits

## Ticket Status

After creation, the ticket will have one of these statuses:
- `new` - Just created, not yet viewed
- `open` - Currently being worked on
- `pending` - Waiting for customer response
- `hold` - Waiting for third party
- `solved` - Issue resolved
- `closed` - Permanently closed

## Testing

To test with your Zendesk instance:

1. Set up your environment variables
2. Modify the test values in `run.xs` or pass them at runtime
3. Run the job and check your Zendesk dashboard for the new ticket

## Security Notes

- Never commit your `ZENDESK_API_TOKEN` to version control
- Use a dedicated API token for Xano integrations
- Restrict the token permissions to only what's needed (tickets:write)
- Rotate tokens periodically for security
