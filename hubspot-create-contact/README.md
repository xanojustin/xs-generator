# HubSpot Create Contact Run Job

This Xano run job creates a new contact in HubSpot CRM using the HubSpot Contacts API.

## What It Does

The run job demonstrates how to:
- Create a contact in HubSpot with properties like email, name, phone, company, and job title
- Handle optional fields dynamically
- Process API responses including error cases (like duplicate contacts)
- Use proper authentication with HubSpot's private app access tokens

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `HUBSPOT_ACCESS_TOKEN` | HubSpot Private App access token | Create a private app in HubSpot Settings → Integrations → Private Apps |

### Setting up HubSpot Access Token

1. Go to your HubSpot account settings
2. Navigate to Integrations → Private Apps
3. Click "Create private app"
4. Give it a name (e.g., "Xano Integration")
5. Grant the following scopes:
   - `crm.objects.contacts.write`
   - `crm.objects.contacts.read`
6. Save and copy the access token
7. Set it as `HUBSPOT_ACCESS_TOKEN` in your Xano environment variables

## How to Use

### As a Run Job

The run job will execute with the default input values defined in `run.xs`. Modify the input object in `run.xs` with your contact details:

```xs
run.job "HubSpot Create Contact" {
  main = {
    name: "create_hubspot_contact"
    input: {
      email: "jane.smith@example.com"
      first_name: "Jane"
      last_name: "Smith"
      phone: "+1-555-0123"
      company: "TechCorp"
      job_title: "Product Manager"
    }
  }
  env = ["HUBSPOT_ACCESS_TOKEN"]
}
```

### As a Reusable Function

You can also call the function directly from other XanoScript code:

```xs
function.run {
  name = "create_hubspot_contact"
  input = {
    email: "contact@example.com",
    first_name: "Alice",
    last_name: "Johnson",
    company: "Startup Inc"
  }
} as $result
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | text | Yes | The contact's email address (unique identifier) |
| `first_name` | text | No | The contact's first name |
| `last_name` | text | No | The contact's last name |
| `phone` | text | No | The contact's phone number |
| `company` | text | No | The contact's company name |
| `job_title` | text | No | The contact's job title |

## Response

### Success Response
```json
{
  "success": true,
  "contact_id": "12345",
  "email": "example@company.com",
  "message": "Contact created successfully in HubSpot"
}
```

### Error Response (Duplicate)
```json
{
  "success": false,
  "error": "Contact already exists with this email",
  "email": "example@company.com"
}
```

### Error Response (API Error)
```json
{
  "success": false,
  "error": "HubSpot API error: 400 - Invalid email format",
  "status_code": 400
}
```

## File Structure

```
hubspot-create-contact/
├── run.xs                    # Run job configuration
├── function/
│   └── create_hubspot_contact.xs  # Main function logic
└── README.md                 # This file
```

## API Reference

This implementation uses the HubSpot CRM API v3:
- **Endpoint**: `POST /crm/v3/objects/contacts`
- **Documentation**: https://developers.hubspot.com/docs/api/crm/contacts

## Notes

- HubSpot uses email as a unique identifier for contacts
- If a contact with the same email already exists, the API returns a 409 status code
- The function handles optional fields by only including them in the request if they have non-empty values
