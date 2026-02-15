# DocuSign Send Envelope Run Job

This XanoScript run job creates and sends a DocuSign envelope for electronic signature using the DocuSign eSignature REST API.

## What It Does

This run job automates the process of sending documents for e-signature through DocuSign. It handles:

- Creating a new envelope with a base64-encoded document
- Adding a single signer with signature and date fields
- Automatically placing signature tabs on the first page
- Sending the envelope immediately (status: "sent")
- Returning the envelope ID and status for tracking

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `DOCUSIGN_ACCOUNT_ID` | Your DocuSign account ID (found in the DocuSign Admin panel) |
| `DOCUSIGN_ACCESS_TOKEN` | Your DocuSign OAuth2 access token |

## Getting DocuSign Credentials

### Account ID
1. Log in to your DocuSign account
2. Go to Settings → Apps and Keys
3. Your Account ID is displayed at the top

### Access Token
You'll need to generate an OAuth2 access token. Options include:
- **JWT Grant**: For service-to-service authentication
- **Authorization Code Grant**: For user authentication flows
- **DocuSign Developer Account**: Sign up at https://developers.docusign.com/ for free testing

For testing, you can generate a temporary token from the DocuSign Developer Center.

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `subject` | text | Yes | Subject line for the signature request email |
| `signer_name` | text | Yes | Full name of the person who will sign |
| `signer_email` | text | Yes | Email address where the signature request will be sent |
| `document_base64` | text | Yes | Base64-encoded document content |
| `document_name` | text | No | Name of the document file (default: "document.pdf") |
| `document_file_extension` | text | No | File extension without dot (default: "pdf") |

### Response

Success response:
```json
{
  "success": true,
  "envelope_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "status": "sent",
  "envelope_uri": "/restapi/v2.1/accounts/123456/envelopes/a1b2c3d4...",
  "error": null
}
```

Error response:
```json
{
  "success": false,
  "envelope_id": null,
  "status": null,
  "envelope_uri": null,
  "error": "USER_AUTHENTICATION_FAILED"
}
```

## File Structure

```
docusign-send-envelope/
├── run.xs                         # Run job definition
├── function/
│   └── send_envelope.xs           # Function to create and send envelope
├── README.md                      # This file
└── FEEDBACK.md                    # MCP/XanoScript feedback
```

## DocuSign API Reference

- [eSignature REST API Documentation](https://developers.docusign.com/docs/esign-rest-api/)
- [Envelopes: Create](https://developers.docusign.com/docs/esign-rest-api/reference/envelopes/envelopes/create/)
- [Authentication Guide](https://developers.docusign.com/platform/auth/)

## Testing

Use the DocuSign Developer Sandbox (demo.docusign.net) for testing:
1. Create a free developer account at https://developers.docusign.com/
2. Generate an integration key
3. Authenticate to get an access token
4. Use the demo environment endpoints

## Security Notes

- Never commit your `DOCUSIGN_ACCESS_TOKEN` to version control
- Use short-lived access tokens when possible
- Store credentials in environment variables or secure vaults
- The demo environment (demo.docusign.net) is recommended for development

## Limitations

- This implementation places signature tabs at fixed coordinates (100, 150)
- Only supports a single signer per envelope
- Documents are limited to base64-encoded content
- For production use, implement proper OAuth token refresh
