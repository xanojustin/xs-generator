# Airtable Create Record - Xano Run Job

This Xano Run Job creates a record in an Airtable base using the Airtable API. It demonstrates how to integrate with Airtable's database-like service from Xano.

## What This Run Job Does

The `Airtable Create Record` run job creates a new record by:
1. Accepting Airtable base ID, table name, and field data
2. Making an authenticated POST request to Airtable's API
3. Returning the created record with its unique Airtable record ID

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `airtable_api_key` | Your Airtable Personal Access Token or API Key | `patXXX...` or `keyXXX...` |

### Getting Your Airtable API Key

1. Log in to your [Airtable account](https://airtable.com)
2. Go to [Developer Hub](https://airtable.com/create/tokens) or Account → Developer
3. Create a new Personal Access Token (recommended) or use your legacy API key
4. Copy the token/key for use in your environment variables

**Note:** Personal Access Tokens (starting with `pat`) are the modern authentication method and are recommended over legacy API keys.

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Airtable Create Record"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Airtable Create Record"
}
```

### Customizing the Record

Edit the `input` block in `run.xs`:

```xs
run.job "Airtable Create Record" {
  main = {
    name: "airtable_create_record"
    input: {
      base_id: "appYOURBASEID123"           // Your Airtable Base ID
      table_name: "Table%201"               // URL-encoded table name
      fields: {
        Name: "New Project"
        Status: "In Progress"
        Priority: "High"
        "Due Date": "2026-02-28"
        Notes: "Created via Xano Run Job"
      }
    }
  }
  env = ["airtable_api_key"]
}
```

### Finding Your Base ID and Table Name

**Base ID:**
1. Open your Airtable base
2. Look at the URL: `https://airtable.com/appXXXXXX/tblYYYYYY/viwZZZZZZ`
3. The Base ID is the part starting with `app` (e.g., `appXXXXXX`)

**Table Name:**
- Use the exact table name as shown in Airtable
- URL-encode spaces and special characters (e.g., "Table 1" becomes "Table%201")
- Or use the table ID (starts with `tbl`)

## File Structure

```
airtable-create-record/
├── run.xs                           # Run job configuration
├── function/
│   └── airtable_create_record.xs    # Function that calls Airtable API
├── README.md                        # This file
└── FEEDBACK.md                      # Development feedback
```

## Response Format

On success, the function returns an Airtable record object:

```json
{
  "id": "recXXXXXXXXXXXXXX",
  "createdTime": "2026-02-16T23:45:00.000Z",
  "fields": {
    "Name": "Test Record from Xano Run Job",
    "Notes": "Created via XanoScript",
    "Status": "In Progress"
  }
}
```

## Error Handling

The function throws an `AirtableAPIError` if:
- The Airtable API returns a non-2xx status code
- The request times out
- Authentication fails (invalid API key)
- The base or table doesn't exist
- Required fields are missing or invalid

Common error codes:
- `422` - Invalid fields or validation errors
- `404` - Base or table not found
- `403` - Permission denied (check your token scopes)
- `401` - Invalid or expired API key

## Security Notes

- **Never commit your Airtable API key** - always use environment variables
- Create a Personal Access Token with minimal required scopes (only `data.records:write` for this job)
- Consider using separate bases for development and production
- The API key has access to all bases it was granted permission to - protect it carefully

## Airtable Field Types

When creating records, format your fields according to Airtable's field types:

| Field Type | Example Value |
|------------|---------------|
| Single line text | `"Project Alpha"` |
| Long text | `"Detailed notes here..."` |
| Number | `42` or `3.14` |
| Checkbox | `true` or `false` |
| Date | `"2026-02-16"` or `"2026-02-16T15:30:00.000Z"` |
| Single select | `"In Progress"` |
| Multiple select | `["Tag1", "Tag2"]` |
| Link to another record | `["recXXXXXXXXXXXXXX"]` |
| Attachment | `[{url: "https://example.com/file.pdf"}]` |

## Additional Resources

- [Airtable API Documentation](https://airtable.com/developers/web/api/introduction)
- [Airtable Personal Access Tokens](https://airtable.com/developers/web/guides/personal-access-tokens)
- [XanoScript Documentation](https://docs.xano.com)
