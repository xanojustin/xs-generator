# Airtable Create Record Run Job

A XanoScript run job that creates records in an Airtable base via the Airtable API.

## What It Does

This run job creates a new record in a specified Airtable table with the provided field values. It's perfect for:

- Adding new tasks, contacts, or entries to your Airtable bases
- Automating data entry workflows
- Integrating Airtable with other systems
- Creating records from form submissions or API calls

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `airtable_api_key` | Your Airtable Personal Access Token (starts with `pat`) or API Key |

### Getting Your Airtable API Key

1. Go to https://airtable.com/create/tokens
2. Click "Create new token"
3. Give it a name (e.g., "Xano Integration")
4. Add the required scopes:
   - `data.records:write` - Create and modify records
   - `data.records:read` - Read records (optional but recommended)
5. Select the bases you want to access
6. Copy the generated token

**Note:** Legacy API keys (starting with `key`) are deprecated. Use Personal Access Tokens (starting with `pat`) instead.

## How to Use

### 1. Set the Environment Variable

```bash
export airtable_api_key="patXXXXXXXX.XXXXXXXX"
```

### 2. Configure the Run Job

Edit `run.xs` with your specific Airtable details:

```xs
run.job "Airtable Create Record" {
  main = {
    name: "airtable_create_record"
    input: {
      base_id: "appYourBaseIdHere"
      table_name: "Your Table Name"
      fields: {
        "Field Name": "Field Value"
        "Another Field": "Another Value"
        "Number Field": 42
        "Checkbox Field": true
      }
    }
  }
  env = ["airtable_api_key"]
}
```

### 3. Run the Job

Using the Xano CLI or Run API to execute the job.

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `base_id` | text | Yes | Your Airtable Base ID (starts with `app`) |
| `table_name` | text | Yes | Table name (as shown in Airtable) or Table ID (starts with `tbl`) |
| `fields` | object | Yes | Object containing field names and values for the new record |

### Finding Your Base ID

1. Open your Airtable base in the browser
2. Look at the URL: `https://airtable.com/appXXXXXXXXXXXXXX/...`
3. The Base ID is the part starting with `app`

Or use the Airtable API documentation: https://airtable.com/developers/web/api/introduction

### Field Types Reference

When specifying fields, use Airtable's field type format:

| Airtable Field Type | Example Value |
|---------------------|---------------|
| Single line text | `"Task Name"` |
| Long text | `"Detailed description..."` |
| Number | `42` or `3.14` |
| Checkbox | `true` or `false` |
| Date | `"2026-02-15"` or `"2026-02-15T10:30:00.000Z"` |
| Single select | `"In Progress"` |
| Multiple select | `["Option 1", "Option 2"]` |
| Link to another record | `["recXXXXXXXXXXXXXX"]` |
| Email | `"user@example.com"` |
| URL | `"https://example.com"` |
| Phone | `"+1 555-123-4567"` |

## File Structure

```
airtable-create-record/
├── run.xs                              # Run job configuration
├── functions/
│   └── airtable_create_record.xs       # Function that calls Airtable API
└── README.md                           # This file
```

## API Reference

This implementation uses the Airtable REST API:

### Create Records
- Endpoint: `POST https://api.airtable.com/v0/{baseId}/{tableIdOrName}`
- Documentation: https://airtable.com/developers/web/api/create-records

## Response

On success, the function returns:

```json
{
  "success": true,
  "record_id": "recXXXXXXXXXXXXXX",
  "created_time": "2026-02-12T18:30:00.000Z",
  "fields": {
    "Task Name": "New Automated Task",
    "Status": "In Progress",
    "Priority": "High"
  }
}
```

## Error Handling

The function validates inputs and returns clear error messages for:

- Missing required fields (`base_id`, `table_name`, `fields`)
- Empty fields object
- Invalid API key (401 Unauthorized)
- Base or table not found (404 Not Found)
- Invalid field names or types (422 Unprocessable Entity)
- Rate limiting (429 Too Many Requests)

### Common Errors

| Error | Cause | Solution |
|-------|-------|----------|
| `Authentication required` | Invalid or expired API key | Generate a new Personal Access Token |
| `NOT_FOUND` | Base ID or Table name is incorrect | Verify your Base ID and table name |
| `UNKNOWN_FIELD_NAME` | Field doesn't exist in table | Check field names match exactly (case-sensitive) |
| `INVALID_VALUE_FOR_COLUMN` | Wrong data type for field | Ensure field values match Airtable's expected format |

## Example Usage Scenarios

### Create a Task Record

```xs
input: {
  base_id: "appXXXXXXXXXXXXXX"
  table_name: "Tasks"
  fields: {
    "Task Name": "Review Q1 Marketing Plan"
    "Status": "To Do"
    "Priority": "High"
    "Due Date": "2026-03-01"
    "Assigned To": ["recUserRecordId1"]
  }
}
```

### Create a Contact Record

```xs
input: {
  base_id: "appXXXXXXXXXXXXXX"
  table_name: "Contacts"
  fields: {
    "Name": "Jane Smith"
    "Email": "jane.smith@example.com"
    "Phone": "+1 555-987-6543"
    "Company": "Acme Corp"
    "Active": true
  }
}
```

### Create an Order Record

```xs
input: {
  base_id: "appXXXXXXXXXXXXXX"
  table_name: "Orders"
  fields: {
    "Order ID": "ORD-2026-0001"
    "Customer": ["recCustomerId"]
    "Total": 149.99
    "Status": "Pending"
    "Order Date": "2026-02-12"
    "Items": "Widget A, Widget B, Widget C"
  }
}
```

## Rate Limits

Airtable API has rate limits:
- **Free plan**: 1,000 requests per month
- **Plus/Pro plans**: 5,000+ requests per month
- Rate limit headers are included in API responses

For high-volume operations, consider batching requests or using Airtable's bulk create endpoint.

## License

MIT