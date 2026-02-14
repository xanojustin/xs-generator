# HubSpot Create Contact Run Job

This XanoScript run job creates a contact in HubSpot CRM using the HubSpot API.

## What It Does

This run job creates a new contact in your HubSpot CRM. It handles:

- Creating a contact with required email field
- Adding optional contact properties (name, company, phone, job title)
- Setting the lifecycle stage of the contact
- Handling duplicate contact errors (409 conflict)
- Returning the created contact ID and properties

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `HUBSPOT_ACCESS_TOKEN` | Your HubSpot private app access token (starts with `pat-na-...`) |

### Getting a HubSpot Access Token

1. Go to your HubSpot account settings
2. Navigate to **Integrations > Private Apps**
3. Create a new private app
4. Grant the following scopes:
   - `crm.objects.contacts.write`
   - `crm.objects.contacts.read`
5. Copy the access token

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | text | Yes | Contact email address (must be unique) |
| `firstname` | text | No | Contact first name |
| `lastname` | text | No | Contact last name |
| `company` | text | No | Company name |
| `phone` | text | No | Phone number |
| `jobtitle` | text | No | Job title |
| `lifecyclestage` | text | No | Lifecycle stage (default: `subscriber`). Options: `subscriber`, `lead`, `marketingqualifiedlead`, `salesqualifiedlead`, `opportunity`, `customer`, `evangelist`, `other` |

### Response (Success)

```json
{
  "success": true,
  "contact_id": "12345",
  "created_at": "2024-01-15T10:30:00.000Z",
  "properties": {
    "email": "test@example.com",
    "firstname": "John",
    "lastname": "Doe",
    "company": "Acme Inc",
    "phone": "+1-555-123-4567",
    "jobtitle": "Software Engineer",
    "lifecyclestage": "subscriber",
    "createdate": "2024-01-15T10:30:00.000Z",
    "lastmodifieddate": "2024-01-15T10:30:00.000Z"
  },
  "error": null
}
```

### Response (Duplicate Contact)

```json
{
  "success": false,
  "contact_id": null,
  "created_at": null,
  "properties": null,
  "error": "Contact with this email already exists in HubSpot"
}
```

### Response (Error)

```json
{
  "success": false,
  "contact_id": null,
  "created_at": null,
  "properties": null,
  "error": "HubSpot API error: HTTP 401"
}
```

## File Structure

```
hubspot-create-contact/
├── run.xs                    # Run job definition
├── function/
│   └── create_contact.xs     # Function to create contact
└── README.md                 # This file
```

## HubSpot API Reference

- [Contacts API Documentation](https://developers.hubspot.com/docs/api/crm/contacts)
- [Create Contact Endpoint](https://developers.hubspot.com/docs/api/crm/contacts#endpoint?spec=POST-/crm/v3/objects/contacts)
- [Lifecycle Stages](https://developers.hubspot.com/docs/api/crm/contacts#contact-properties)

## Lifecycle Stages

HubSpot uses the following lifecycle stages:

| Stage | Description |
|-------|-------------|
| `subscriber` | Signed up for blog/email updates |
| `lead` | Converted on a form |
| `marketingqualifiedlead` | Marketing qualified |
| `salesqualifiedlead` | Sales qualified |
| `opportunity` | Active deal in pipeline |
| `customer` | Won deal, paying customer |
| `evangelist` | Active promoter |
| `other` | Other |

## Testing

Use test email addresses that you own for testing:
- `test+timestamp@yourdomain.com` (Gmail supports + aliases)
- Use different emails each time since HubSpot enforces unique emails

## Security Notes

- Never commit your `HUBSPOT_ACCESS_TOKEN` to version control
- Use a private app with minimal required scopes
- Rotate your access tokens regularly
- Consider using a test HubSpot account for development

## Rate Limits

HubSpot API has rate limits based on your account type:
- Free/Starter: 100 requests per 10 seconds
- Professional/Enterprise: Higher limits

The API returns a 429 status code if you exceed the rate limit.
