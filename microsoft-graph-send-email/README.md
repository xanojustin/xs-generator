# Microsoft Graph Send Email Run Job

This Xano Run Job sends emails using the Microsoft Graph API (Outlook/Office 365).

## Overview

This run job authenticates with Microsoft Graph using OAuth 2.0 client credentials flow and sends emails through an Office 365/Microsoft 365 mailbox.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `MS_GRAPH_CLIENT_ID` | Azure AD application client ID |
| `MS_GRAPH_CLIENT_SECRET` | Azure AD application client secret |
| `MS_GRAPH_TENANT_ID` | Azure AD tenant ID (directory ID) |
| `MS_GRAPH_FROM_EMAIL` | The sender's email address (must be a mailbox in your tenant) |

## Azure AD Setup

1. Register an application in Azure AD
2. Grant `Mail.Send` application permission
3. Create a client secret
4. Grant admin consent for the permission

## Files

- `run.xs` - Run job configuration
- `function/send_outlook_email.xs` - Email sending logic

## Input Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `to_address` | text | required | Recipient email address |
| `subject` | text | required | Email subject line |
| `body` | text | required | Email body content |
| `body_content_type` | text | "HTML" | Content type: "HTML" or "Text" |

## Usage

### Run with default values

```bash
xano run run.xs
```

### Run with custom parameters

```bash
xano run run.xs --input '{"to_address":"user@company.com","subject":"Hello","body":"Your message here"}'
```

## Response

On success, returns:
```json
{
  "success": true,
  "message": "Email sent successfully via Microsoft Graph",
  "to": "recipient@example.com",
  "subject": "Hello from Xano",
  "sent_at": "2025-02-16T03:45:00Z"
}
```

## Error Handling

The job validates inputs and will throw errors for:
- Missing or invalid recipient email
- Missing subject or body
- Failed authentication with Microsoft Graph
- Failed email delivery

## API Reference

- [Microsoft Graph Mail API](https://docs.microsoft.com/en-us/graph/api/user-sendmail)
- [Microsoft Graph Auth](https://docs.microsoft.com/en-us/graph/auth/auth-concepts)