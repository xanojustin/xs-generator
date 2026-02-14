# Airtable Create Record

A Xano Run Job that creates records in an Airtable base using the Airtable API.

## What This Run Job Does

This run job creates a new record in a specified Airtable table with the provided field values. It handles authentication, request formatting, and provides detailed error handling for common Airtable API error scenarios.

## Prerequisites

1. An Airtable account with a base and table set up
2. An Airtable personal access token or API key

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `AIRTABLE_API_KEY` | Your Airtable personal access token or legacy API key. Create one at https://airtable.com/create/tokens |

## Input Parameters

The `create_record` function accepts the following inputs:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `base_id` | text | Yes | Your Airtable base ID (found in the URL: https://airtable.com/app1234567890abcd/...) |
| `table_name` | text | Yes | The table name (e.g., "Tasks") or table ID (e.g., "tbl1234567890abcd") |
| `fields` | text | Yes | A JSON string containing field names and values for the new record |
| `typecast` | text | No | Set to "true" to enable type coercion for field values |

## How to Use

### 1. Configure Environment Variables

Set your Airtable API key as an environment variable:
```
AIRTABLE_API_KEY=pat1234567890abcdef
```

### 2. Get Your Base ID

Find your base ID in your Airtable URL:
```
https://airtable.com/app1234567890abcd/tblXXXXXXXXXXXXXX/viwXXXXXXXXXXXXXX
                 ^^^^^^^^^^^^^^^^^
                 This is your base_id
```

### 3. Customize the Run Job

Edit `run.xs` to set your specific values:

```xs
run.job "Airtable Create Record" {
  main = {
    name: "create_record"
    input: {
      base_id: "app1234567890abcd"      // Your actual base ID
      table_name: "Tasks"                // Your table name
      fields: "{\"Name\":\"My New Task\",\"Status\":\"In Progress\",\"Priority\":\"High\"}"
    }
  }
  env = ["AIRTABLE_API_KEY"]
}
```

### 4. Run the Job

Use the Xano CLI or Run API to execute the job.

## Example Response

On success:
```json
{
  "success": true,
  "record_id": "rec1234567890abcd",
  "record": {
    "id": "rec1234567890abcd",
    "createdTime": "2026-02-13T19:45:00.000Z",
    "fields": {
      "Name": "My New Task",
      "Status": "In Progress",
      "Priority": "High"
    }
  },
  "error": null
}
```

On error:
```json
{
  "success": false,
  "record_id": null,
  "record": null,
  "error": "Bad request - check your field names and values"
}
```

## Error Handling

The job handles the following HTTP status codes:

- **200** - Success! Record created
- **400** - Bad request (invalid field names or values)
- **401** - Unauthorized (invalid API key)
- **403** - Forbidden (insufficient permissions)
- **404** - Not found (invalid base_id or table_name)
- **422** - Validation failed (field type mismatch)

## Field Types in JSON

Airtable supports various field types. Here are common examples for your JSON payload:

| Field Type | Example JSON Value |
|------------|-------------------|
| Single line text | `"Task Name"` |
| Long text | `"Description here..."` |
| Number | `42` or `3.14` |
| Checkbox | `true` or `false` |
| Date | `"2026-02-13"` |
| Single select | `"In Progress"` |
| Multiple select | `["Tag1", "Tag2"]` |
| Link to another record | `["rec1234567890abcd"]` |

Example fields JSON:
```json
{
  "Name": "Complete documentation",
  "Status": "In Progress",
  "Priority": "High",
  "DueDate": "2026-02-20",
  "Completed": false,
  "Tags": ["Documentation", "API"]
}
```

As a string for the input parameter:
```xs
fields: "{\"Name\":\"Complete documentation\",\"Status\":\"In Progress\",\"Priority\":\"High\",\"DueDate\":\"2026-02-20\",\"Completed\":false,\"Tags\":[\"Documentation\",\"API\"]}"
```

## Typecast Option

Enable typecast to let Airtable automatically convert values:

```xs
input: {
  base_id: "app1234567890abcd"
  table_name: "Tasks"
  fields: "{\"Status\":\"In Progress\"}"
  typecast: "true"
}
```

## Resources

- [Airtable API Documentation](https://airtable.com/developers/web/api/introduction)
- [Create Personal Access Token](https://airtable.com/create/tokens)
- [Field Type Reference](https://airtable.com/developers/web/api/field-model)

## Folder Structure

```
airtable-create-record/
├── run.xs              # Run job definition
├── function/
│   └── create_record.xs  # Main function logic
└── README.md           # This file
```
