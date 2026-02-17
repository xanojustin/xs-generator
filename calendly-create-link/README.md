# Calendly Create Scheduling Link

This Xano Run Job creates a one-time scheduling link via the Calendly API. Scheduling links allow invitees to book a meeting without needing to select from available time slots.

## What It Does

Creates a scheduling link for a specific Calendly event type. The link can optionally be pre-filled with invitee information (name and email).

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `calendly_api_key` | Your Calendly Personal Access Token. Get it from https://calendly.com/integrations/api_webhooks |

## How to Use

### 1. Set up environment variables
```bash
export calendly_api_key="your_calendly_personal_access_token"
```

### 2. Run the job
```bash
xano job run ./calendly-create-link
```

Or with input parameters:
```bash
xano job run ./calendly-create-link --input '{"event_type_uuid":"your-event-type-uuid","email":"invite@example.com","name":"John Doe"}'
```

### 3. Get your Event Type UUID
To get your event type UUID:
1. Go to https://calendly.com/integrations/api_webhooks
2. Click "Use API"
3. Call `GET /event_types` to list your event types
4. Extract the UUID from the `uri` field (the part after `/event_types/`)

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `event_type_uuid` | text | Yes | The UUID of the Calendly event type |
| `email` | text | No | Pre-fill invitee email |
| `name` | text | No | Pre-fill invitee name |

## Output

On success, returns:
```json
{
  "success": true,
  "booking_url": "https://calendly.com/d/abc123/30min",
  "event_type": "https://api.calendly.com/event_types/abc-123-uuid",
  "status": "open"
}
```

## API Reference

- Calendly API Docs: https://developer.calendly.com/api-docs
- Scheduling Links: https://developer.calendly.com/api-docs/3e8f7f07889bd-create-a-scheduling-link

## Error Handling

The job handles these error cases:
- `401` - Invalid API key
- `404` - Event type not found
- Other API errors with detailed messages

## Files

```
calendly-create-link/
├── run.xs                          # Run job configuration
├── function/
│   └── create_scheduling_link.xs   # Main logic
└── README.md                       # This file
```
