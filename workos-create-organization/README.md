# WorkOS Create Organization

A Xano run job that creates organizations in [WorkOS](https://workos.com), an enterprise identity platform for SSO, Directory Sync, and Audit Logs.

## What This Run Job Does

This run job provisions a new organization in WorkOS. Organizations are the top-level entity in WorkOS that contain:
- **SSO Connections** - SAML/OIDC identity provider configurations
- **Directory Sync** - SCIM provisioning from identity providers
- **Admin Portal** - Self-serve configuration for your customers
- **Audit Logs** - Security event logging

## Use Cases

- Onboarding new enterprise customers who need SSO
- Automating organization provisioning from your signup flow
- Syncing organization data from your CRM to WorkOS
- Bulk importing organizations during migration

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `WORKOS_API_KEY` | Your WorkOS API key | [WorkOS Dashboard](https://dashboard.workos.com) → API Keys |

## How to Use

### 1. Set Environment Variable

```bash
export WORKOS_API_KEY="sk_test_xxxxxxxxxxxxxxxxxxxx"
```

### 2. Customize Input (Optional)

Edit `run.xs` to change the organization details:

```xs
input: {
  name: "Your Company Name"      // Required: Organization display name
  domain: "yourdomain.com"       // Optional: Primary domain for SSO
  external_id: "your-ref-123"    // Optional: Your internal reference ID
  metadata: {                    // Optional: Custom key-value data
    plan: "enterprise"
    region: "us-west"
  }
}
```

### 3. Run the Job

```bash
xano run
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | text | Yes | The organization's display name |
| `domain` | text | No | Primary email domain for SSO matching |
| `external_id` | text | No | Your application's unique identifier |
| `metadata` | json | No | Custom key-value pairs (up to 50 keys) |

## Response

On success, returns the created organization object:

```json
{
  "id": "org_xxxxxxxxxxxxxxxx",
  "name": "Acme Corporation",
  "domains": ["acme.com"],
  "external_id": "acme-corp-001",
  "metadata": {
    "plan": "enterprise",
    "region": "us-west"
  },
  "created_at": "2024-01-15T10:30:00.000Z",
  "updated_at": "2024-01-15T10:30:00.000Z"
}
```

## Error Handling

The run job handles these error cases:

| Error | Cause | Solution |
|-------|-------|----------|
| `InputError` | Missing organization name | Provide a valid `name` parameter |
| `ConflictError` | Domain already in use | Use a different domain or check existing orgs |
| `AuthError` | Invalid API key | Verify your `WORKOS_API_KEY` is correct |
| `APIError` | WorkOS API failure | Check WorkOS status and retry |

## WorkOS Documentation

- [WorkOS API Reference](https://workos.com/docs/reference)
- [Organizations API](https://workos.com/docs/reference/organization)
- [Admin Portal Guide](https://workos.com/docs/admin-portal)

## File Structure

```
workos-create-organization/
├── run.xs                                    # Run job configuration
├── function/
│   └── create_workos_organization.xs         # Main function
├── README.md                                 # This file
└── FEEDBACK.md                               # Development feedback
```

## License

MIT
