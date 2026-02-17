# Supabase Insert Record - Xano Run Job

This Xano Run Job inserts a record into a Supabase table using the Supabase REST API. It demonstrates how to integrate with Supabase from Xano.

## What This Run Job Does

The `Supabase Insert Record` run job:
1. Accepts a table name and data object
2. Authenticates with Supabase using your API key
3. Inserts the record into the specified table
4. Returns the inserted record with generated fields (like `id`, `created_at`)

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `SUPABASE_URL` | Your Supabase project URL | Yes |
| `SUPABASE_ANON_KEY` | Your Supabase anon/public key | Yes* |
| `SUPABASE_SERVICE_ROLE_KEY` | Your Supabase service role key | Yes* |

\* You need either `SUPABASE_SERVICE_ROLE_KEY` (recommended for server-side) or `SUPABASE_ANON_KEY`. If both are provided, the service role key takes precedence.

### Getting Your Supabase Credentials

1. Log in to your [Supabase Dashboard](https://app.supabase.com)
2. Select your project
3. Go to Project Settings → API
4. Copy the following:
   - **Project URL** (e.g., `https://your-project.supabase.co`)
   - **anon public** key (for `SUPABASE_ANON_KEY`)
   - **service_role secret** key (for `SUPABASE_SERVICE_ROLE_KEY`)

**Note:** The service role key bypasses Row Level Security (RLS), so keep it secure and only use it server-side.

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Supabase Insert Record"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Supabase Insert Record"
}
```

### Customizing the Insert

Edit the `input` block in `run.xs`:

```xs
run.job "Supabase Insert Record" {
  main = {
    name: "supabase_insert_record"
    input: {
      table: "users"
      data: {
        email: "user@example.com"
        name: "Jane Smith"
        status: "active"
        role: "customer"
      }
      conflict_resolution: "ignore"  // Options: "error", "ignore", "update"
      returning_columns: ["id", "email", "name", "created_at"]
    }
  }
  env = ["SUPABASE_URL", "SUPABASE_ANON_KEY", "SUPABASE_SERVICE_ROLE_KEY"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `table` | text | Yes | Name of the Supabase table |
| `data` | json | Yes | Object containing the data to insert |
| `conflict_resolution` | text | No | How to handle conflicts: `"error"` (default), `"ignore"`, or `"update"` |
| `returning_columns` | text[] | No | Array of column names to return. If omitted, returns all columns |

### Conflict Resolution Options

- **`"error"`** (default): Throws an error if a record with the same primary key exists
- **`"ignore"`**: Silently skips the insert if a conflict occurs
- **`"update"`**: Updates the existing record on conflict (upsert behavior)

## File Structure

```
supabase-insert-record/
├── run.xs                              # Run job configuration
├── function/
│   └── supabase_insert_record.xs       # Function that calls Supabase API
└── README.md                           # This file
```

## Response Format

On success, the function returns:

```json
{
  "success": true,
  "table": "users",
  "data": [
    {
      "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "email": "user@example.com",
      "name": "Jane Smith",
      "status": "active",
      "role": "customer",
      "created_at": "2024-01-15T10:30:00.000Z"
    }
  ]
}
```

**Note:** The `data` field is an array because Supabase can insert multiple records in one request.

## Error Handling

The function throws specific errors for different failure scenarios:

| Error Type | When It Occurs |
|------------|----------------|
| `inputerror` | Missing/invalid table name or empty data |
| `standard` | Missing required environment variables |
| `SupabaseConflictError` | Record already exists (status 409) |
| `SupabaseAPIError` | Other API errors (non-2xx status) |

## Supabase Table Setup

Before using this run job, ensure:

1. Your table exists in Supabase
2. You have the correct RLS policies if using the anon key
3. The columns in your `data` object match the table schema

### Example Table Schema

```sql
create table users (
  id uuid default gen_random_uuid() primary key,
  email text unique not null,
  name text not null,
  status text default 'active',
  role text default 'customer',
  created_at timestamp with time zone default now()
);
```

### Row Level Security (RLS)

If using the anon key, enable RLS and create policies:

```sql
-- Enable RLS
alter table users enable row level security;

-- Allow inserts (adjust for your use case)
create policy "Allow inserts" on users
  for insert with check (true);
```

**Recommendation:** For server-side operations, use the service role key and keep RLS enabled for security.

## Security Notes

- **Never commit your service role key** - always use environment variables
- The service role key bypasses all RLS policies - keep it secret
- Use the anon key for client-side operations with proper RLS policies
- Enable RLS on all tables in production

## Additional Resources

- [Supabase REST API Documentation](https://supabase.com/docs/guides/api)
- [Supabase JavaScript Client](https://supabase.com/docs/reference/javascript/)
- [PostgREST Documentation](https://postgrest.org/) (Supabase REST is built on PostgREST)
- [XanoScript Documentation](https://docs.xano.com)
