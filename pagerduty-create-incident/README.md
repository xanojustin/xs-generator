# PagerDuty Create Incident - Xano Run Job

This Xano Run Job creates an incident in PagerDuty. It demonstrates how to integrate with PagerDuty's incident management API from Xano.

## What This Run Job Does

The `PagerDuty Create Incident` run job:
1. Accepts incident details (title, description, urgency, service ID)
2. Makes an authenticated request to PagerDuty's `/incidents` endpoint
3. Returns the created incident object with details like incident ID, status, and created_at timestamp

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `pagerduty_api_key` | Your PagerDuty API Key | `u+abcdefghijklmnopqrstuvwxyz` |

### Getting Your PagerDuty API Key

1. Log in to your [PagerDuty account](https://www.pagerduty.com)
2. Go to Integrations → API Access Keys
3. Create a new API key with **Read/Write** permissions
4. Copy the API key (starts with `u+`)

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "PagerDuty Create Incident"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "PagerDuty Create Incident"
}
```

### Customizing the Incident

Edit the `input` block in `run.xs`:

```xs
run.job "PagerDuty Create Incident" {
  main = {
    name: "create_incident"
    input: {
      title: "Database Connection Failure"
      description: "Unable to connect to primary database - connection timeout after 30s"
      urgency: "high"           // 'high' or 'low'
      service_id: "PABC123"     // Your PagerDuty service ID
    }
  }
  env = ["pagerduty_api_key"]
}
```

### Finding Your Service ID

1. Go to **Services** → **Service Directory** in PagerDuty
2. Click on the service you want to create incidents for
3. The Service ID is in the URL: `https://<subdomain>.pagerduty.com/services/PABC123`
4. Copy the ID (e.g., `PABC123`)

## File Structure

```
pagerduty-create-incident/
├── run.xs                    # Run job configuration
├── function/
│   └── create_incident.xs    # Function that calls PagerDuty API
└── README.md                 # This file
```

## Response Format

On success, the function returns a PagerDuty Incident object:

```json
{
  "incident": {
    "id": "PABC123",
    "type": "incident",
    "summary": "Server CPU High Alert",
    "self": "https://api.pagerduty.com/incidents/PABC123",
    "html_url": "https://<subdomain>.pagerduty.com/incidents/PABC123",
    "incident_number": 42,
    "title": "Server CPU High Alert",
    "service": {
      "id": "PABCDEF",
      "type": "service_reference",
      "summary": "Production API Service",
      "self": "https://api.pagerduty.com/services/PABCDEF",
      "html_url": "https://<subdomain>.pagerduty.com/services/PABCDEF"
    },
    "urgency": "high",
    "state": "triggered",
    "trigger_summary_data": {
      "description": "CPU usage exceeded 90% threshold on production server"
    },
    "status": "triggered",
    "created_at": "2024-01-15T10:30:00Z",
    "updated_at": "2024-01-15T10:30:00Z",
    "body": {
      "type": "incident_body",
      "details": "CPU usage exceeded 90% threshold on production server"
    },
    "assignments": [...],
    "assigned_via": "escalation_policy",
    "last_status_change_at": "2024-01-15T10:30:00Z",
    "last_status_change_by": {...},
    "escalation_policy": {...},
    "teams": [...],
    "alert_counts": {
      "all": 1,
      "triggered": 1,
      "resolved": 0
    },
    "is_mergeable": true,
    "conference_bridge": null
  }
}
```

## Error Handling

The function throws a `PagerDutyAPIError` if:
- The PagerDuty API returns a non-2xx status code
- The request times out
- Authentication fails (invalid API key)
- The service ID is invalid or not found
- Required fields are missing

Common error codes:
- `401 Unauthorized` - Invalid or missing API key
- `403 Forbidden` - Insufficient permissions
- `404 Not Found` - Service ID not found
- `400 Bad Request` - Invalid request payload

## Security Notes

- **Never commit your PagerDuty API key** - always use environment variables
- Use a dedicated API key for each integration
- Rotate your API keys periodically
- Consider using PagerDuty's Event Integration (Events API v2) for simpler alerting use cases
- Ensure the API key has the minimum required permissions

## Alternative: Events API v2

For simpler alerting scenarios, consider using the [PagerDuty Events API v2](https://developer.pagerduty.com/docs/events-api-v2-overview) with integration keys instead:

- No user context required (no `From` header needed)
- Simpler authentication (integration key instead of API key)
- Optimized for monitoring tools and event sources

## Additional Resources

- [PagerDuty REST API Documentation](https://developer.pagerduty.com/api-reference/368ae3d938c9e-create-an-incident)
- [PagerDuty Events API v2](https://developer.pagerduty.com/docs/events-api-v2-overview)
- [XanoScript Documentation](https://docs.xano.com)

## Incident Lifecycle

After creation, incidents go through these states:
1. **triggered** - Initial state when created
2. **acknowledged** - Someone has acknowledged the incident
3. **resolved** - The incident has been resolved

You can update incidents via the API to acknowledge or resolve them.