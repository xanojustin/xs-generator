# Zendesk Create Ticket - Xano Run Job

This Xano Run Job creates a support ticket using the Zendesk API. It demonstrates how to integrate with Zendesk's customer support platform from Xano.

## What This Run Job Does

The `Zendesk Create Ticket` run job creates a support ticket by:
1. Accepting ticket details (subject, body, requester info, priority, tags)
2. Making an authenticated request to Zendesk's `/api/v2/tickets.json` endpoint
3. Returning the created ticket object with details like ticket ID, URL, and status

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `zendesk_subdomain` | Your Zendesk subdomain (the part before `.zendesk.com`) | `mycompany` |
| `zendesk_email` | The email address of a Zendesk agent/admin | `agent@mycompany.com` |
| `zendesk_api_token` | Your Zendesk API token | `abc123def456ghi789` |

### Getting Your Zendesk API Credentials

1. **Subdomain**: This is the first part of your Zendesk URL. If your URL is `https://mycompany.zendesk.com`, your subdomain is `mycompany`.

2. **Email**: Use any agent or admin email address that has permission to create tickets.

3. **API Token**:
   - Log in to your Zendesk Admin Center
   - Go to Apps and integrations → APIs → Zendesk API
   - Click the **Settings** tab
   - Enable **Token Access** if not already enabled
   - Click the **+** button to add a new token
   - Copy the token (it starts with a string of letters/numbers)
   - **Important**: Store this token securely - you can only view it once!

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Zendesk Create Ticket"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Zendesk Create Ticket"
}
```

### Customizing the Ticket

Edit the `input` block in `run.xs`:

```xs
run.job "Zendesk Create Ticket" {
  main = {
    name: "zendesk_create_ticket"
    input: {
      subject: "Urgent: Payment Processing Issue"
      body: "Customer is unable to complete checkout. Error code: 5001"
      requester_email: "customer@example.com"
      requester_name: "John Smith"
      priority: "high"
      tags: ["payment", "urgent", "checkout"]
    }
  }
  env = ["zendesk_subdomain", "zendesk_email", "zendesk_api_token"]
}
```

### Priority Levels

- `urgent` - Requires immediate attention
- `high` - Should be addressed quickly
- `normal` - Standard priority (default)
- `low` - Can be addressed when time permits

## File Structure

```
zendesk-create-ticket/
├── run.xs                              # Run job configuration
├── function/
│   └── zendesk_create_ticket.xs        # Function that calls Zendesk API
└── README.md                           # This file
```

## Response Format

On success, the function returns a Zendesk Ticket object:

```json
{
  "ticket": {
    "id": 12345,
    "url": "https://mycompany.zendesk.com/api/v2/tickets/12345.json",
    "external_id": null,
    "via": {
      "channel": "api",
      "source": {
        "from": {},
        "to": {},
        "rel": null
      }
    },
    "created_at": "2024-01-15T10:30:00Z",
    "updated_at": "2024-01-15T10:30:00Z",
    "type": null,
    "subject": "Support Request from Xano Run Job",
    "raw_subject": "Support Request from Xano Run Job",
    "description": "This is a test ticket created via the Xano Run Job integration with Zendesk.",
    "priority": "normal",
    "status": "new",
    "recipient": null,
    "requester_id": 987654321,
    "submitter_id": 987654321,
    "assignee_id": null,
    "organization_id": null,
    "group_id": null,
    "collaborator_ids": [],
    "follower_ids": [],
    "email_cc_ids": [],
    "forum_topic_id": null,
    "problem_id": null,
    "has_incidents": false,
    "is_public": true,
    "due_at": null,
    "tags": ["xano", "api", "test"],
    "custom_fields": [],
    "satisfaction_rating": null,
    "sharing_agreement_ids": [],
    "fields": [],
    "followup_ids": [],
    "ticket_form_id": null,
    "brand_id": 123456,
    "allow_channelback": false,
    "allow_attachments": true
  }
}
```

## Error Handling

The function throws a `ZendeskAPIError` if:
- The Zendesk API returns a non-2xx status code
- The request times out
- Authentication fails (invalid subdomain, email, or API token)
- Required fields are missing
- The requester email is invalid

## Security Notes

- **Never commit your Zendesk API token** - always use environment variables
- Use a dedicated API token for Xano integrations (don't reuse tokens)
- Rotate your API tokens periodically
- Restrict the agent account used for API access to minimum required permissions
- Consider using Zendesk's IP allowlisting for additional security

## Additional Resources

- [Zendesk API Documentation](https://developer.zendesk.com/api-reference/)
- [Zendesk Tickets API](https://developer.zendesk.com/api-reference/ticketing/tickets/tickets/)
- [Zendesk Authentication](https://developer.zendesk.com/api-reference/introduction/security-and-auth/)
- [XanoScript Documentation](https://docs.xano.com)
