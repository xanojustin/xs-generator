# Airtable Create Record

A Xano Run Job that creates a new record in an Airtable base using the Airtable API.

## What It Does

This run job creates a new record in a specified Airtable base and table. It validates the input parameters and makes an authenticated HTTP POST request to the Airtable API.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `airtable_api_key` | Your Airtable Personal Access Token or API Key |

## How to Use

### Input Parameters

```json
{
  "base_id": "appXXXXXXXXXXXXXX",
  "table_name": "Tasks",
  "fields": {
    "Name": "New Task",
    "Status": "In Progress",
    "Due Date": "2026-02-20"
  }
}
```

### Parameter Details

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `base_id` | string | Yes | The ID of your Airtable base (starts with "app") |
| `table_name` | string | Yes | The name or ID of the table to create the record in |
| `fields` | object | Yes | An object containing field names and values for the new record |

### Response

Returns the created record object from Airtable, including the generated record ID:

```json
{
  "id": "recXXXXXXXXXXXXXX",
  "createdTime": "2026-02-13T14:45:00.000Z",
  "fields": {
    "Name": "New Task",
    "Status": "In Progress",
    "Due Date": "2026-02-20"
  }
}
```

## Example Usage

### Creating a Task Record

```json
{
  "base_id": "app1234567890abcd",
  "table_name": "Tasks",
  "fields": {
    "Name": "Review Q1 Report",
    "Assignee": "user@example.com",
    "Priority": "High",
    "Status": "Not Started"
  }
}
```

### Creating a Contact Record

```json
{
  "base_id": "app1234567890abcd",
  "table_name": "Contacts",
  "fields": {
    "First Name": "John",
    "Last Name": "Doe",
    "Email": "john.doe@example.com",
    "Phone": "+1 (555) 123-4567"
  }
}
```

## Getting Your Airtable API Key

1. Go to [Airtable Developer Hub](https://airtable.com/create/tokens)
2. Create a new Personal Access Token
3. Grant it the following scopes:
   - `data.records:write` - to create records
   - `data.records:read` - to read records (optional)
4. Add access to the base(s) you want to work with
5. Copy the token and set it as the `airtable_api_key` environment variable

## Error Handling

The run job validates inputs and will throw errors in the following cases:

- **Input Error (400)**: Missing or invalid input parameters (empty base_id, table_name, or empty fields object)

API-level errors (invalid base ID, table not found, authentication failed, etc.) will be returned in the API response result.

## Files

- `run.xs` - Run job configuration
- `function/create_airtable_record.xs` - Main function implementation

## Resources

- [Airtable API Documentation](https://airtable.com/developers/web/api/introduction)
- [Airtable Personal Access Tokens](https://airtable.com/developers/web/guides/personal-access-tokens)
