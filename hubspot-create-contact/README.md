# HubSpot Create Contact Run Job

A XanoScript run job that creates a new contact in HubSpot CRM.

## What It Does

This run job creates a contact in your HubSpot CRM with the following properties:
- **Email** (required) - Primary identifier for the contact
- **First Name** - Contact's first name
- **Last Name** - Contact's last name  
- **Phone** - Contact's phone number
- **Company** - Company name
- **Job Title** - Contact's job title
- **Lifecycle Stage** - Where the contact is in your funnel (subscriber, lead, marketing qualified lead, sales qualified lead, opportunity, customer, evangelist, other)

Perfect for integrating lead capture forms, user signups, or any workflow where you want to sync contacts to HubSpot.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `hubspot_access_token` | Your HubSpot Private App access token |

### Getting Your Access Token

1. Go to your HubSpot account settings
2. Navigate to **Integrations** → **Private Apps**
3. Create a new Private App
4. Grant it scopes: `crm.objects.contacts.write`, `crm.objects.contacts.read`
5. Copy the access token

**Security Note:** Keep your access token secure. It provides access to your CRM data.

## How to Use

### 1. Set the Environment Variable

```bash
export hubspot_access_token="pat-na1-your_token_here"
```

### 2. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

### 3. Customize the Contact

Edit the `input` block in `run.xs` to customize:

```xs
run.job "HubSpot Create Contact" {
  main = {
    name: "hubspot_create_contact"
    input: {
      email: "jane.smith@acme.com"
      firstname: "Jane"
      lastname: "Smith"
      phone: "+1-555-987-6543"
      company: "Acme Corporation"
      jobtitle: "VP of Engineering"
      lifecyclestage: "lead"
    }
  }
  env = ["hubspot_access_token"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | email | Yes | Contact's email address (unique identifier) |
| `firstname` | text | No | Contact's first name |
| `lastname` | text | No | Contact's last name |
| `phone` | text | No | Contact's phone number |
| `company` | text | No | Company name |
| `jobtitle` | text | No | Contact's job title |
| `lifecyclestage` | text | No | Contact's stage in the lifecycle funnel |

### Lifecycle Stage Options

| Stage | Description |
|-------|-------------|
| `subscriber` | Signed up for blog/email |
| `lead` | Converted on a form |
| `marketingqualifiedlead` | Marketing qualified |
| `salesqualifiedlead` | Sales qualified |
| `opportunity` | Active deal in pipeline |
| `customer` | Paying customer |
| `evangelist` | Promotes your brand |
| `other` | Uncategorized |

## File Structure

```
hubspot-create-contact/
├── run.xs                              # Run job configuration
├── functions/
│   └── hubspot_create_contact.xs       # Function that calls HubSpot API
└── README.md                           # This file
```

## API Reference

This implementation uses the HubSpot CRM API:

### Create Contact
- Endpoint: `POST https://api.hubapi.com/crm/v3/objects/contacts`
- Documentation: https://developers.hubspot.com/docs/api/crm/contacts

## Response

On success, the function returns:

```json
{
  "success": true,
  "contact_id": "12345",
  "email": "jane.smith@acme.com",
  "firstname": "Jane",
  "lastname": "Smith",
  "company": "Acme Corporation",
  "created_at": "2025-02-13T03:14:15.000Z",
  "archived": false
}
```

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing required fields (email)
- Duplicate contacts (email already exists in HubSpot)
- Invalid API tokens
- HubSpot API errors

### Duplicate Contact Handling

If a contact with the same email already exists, the job will fail with a 409 Conflict error and a clear message indicating the duplicate.

## License

MIT
