# Supabase Insert Record

A Xano Run Job that inserts records into a Supabase table via the REST API.

## What This Run Job Does

This run job demonstrates how to integrate Xano with Supabase by inserting a record into a specified Supabase table using the Supabase REST API.

### Features
- Inserts JSON data into any Supabase table
- Proper authentication using Supabase anon key
- Error handling for missing environment variables
- Response validation and structured output

## Required Environment Variables

Set these in your Xano workspace environment variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `SUPABASE_URL` | Your Supabase project URL | `https://abc123.supabase.co` |
| `SUPABASE_ANON_KEY` | Your Supabase anon/public API key | `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` |

## How to Use

### Running the Job

1. Configure your environment variables in Xano
2. Deploy the run job
3. Execute via Xano Job Runner

### Customizing the Insert

Edit the `input` block in `run.xs` to change the table and data:

```xs
run.job "Supabase Insert Record" {
  main = {
    name: "supabase_insert"
    input: {
      table: "your_table_name"
      data: {
        column1: "value1"
        column2: 123
        nested: { key: "value" }
      }
    }
  }
  env = ["supabase_url", "supabase_anon_key"]
}
```

### Function Input Parameters

The `supabase_insert` function accepts:

| Parameter | Type | Description |
|-----------|------|-------------|
| `table` | text | Name of the Supabase table |
| `data` | object | JSON object with record data |

### Response Format

```json
{
  "success": true,
  "status": 201,
  "data": { /* inserted record */ }
}
```

## File Structure

```
supabase-insert-record/
├── run.xs              # Run job definition
├── function/
│   └── supabase_insert.xs  # Main function logic
├── table/
│   └── sync_log.xs     # Example table schema
└── README.md           # This file
```

## API Reference

This run job uses the [Supabase REST API](https://supabase.com/docs/guides/database/rest):

- **Endpoint**: `POST /rest/v1/{table}`
- **Auth**: Bearer token with anon key
- **Headers**: `apikey`, `Authorization`, `Content-Type`

## Notes

- Requires Row Level Security (RLS) policies to allow inserts with anon key, OR use service_role key for admin access
- Returns 201 on successful insert
- Supports any table in your Supabase project
