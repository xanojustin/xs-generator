# Supabase Insert Record

A XanoScript run job that inserts records into a Supabase PostgreSQL database table using the PostgREST API.

## What It Does

This run job connects to your Supabase project and inserts a new record into a specified table. It uses Supabase's REST API (PostgREST) to perform the insertion and returns the created record data including the auto-generated ID.

## Use Cases

- **User Registration**: Automatically create user profiles when new users sign up
- **Event Logging**: Store application events or audit logs in Supabase
- **Data Sync**: Sync data from other sources into your Supabase database
- **Form Submissions**: Save form data directly to Supabase tables
- **E-commerce**: Create orders, products, or customer records

## Required Environment Variables

| Variable | Description | Where to Find |
|----------|-------------|---------------|
| `supabase_url` | Your Supabase project URL | Supabase Dashboard → Project Settings → API → URL |
| `supabase_service_key` | Your service_role secret key | Supabase Dashboard → Project Settings → API → service_role key |

### Important Security Notes

- The `service_role` key has full admin privileges - **never expose it in client-side code**
- Use Row Level Security (RLS) policies in Supabase to protect your data
- Store these credentials securely in Xano's environment variables

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `table_name` | text | Yes | The name of the Supabase table to insert into |
| `data` | json | Yes | Object containing the column names and values for the new record |

## Usage Example

### Basic Usage

```json
{
  "table_name": "users",
  "data": {
    "name": "Jane Doe",
    "email": "jane@example.com",
    "role": "customer"
  }
}
```

### With Additional Fields

```json
{
  "table_name": "orders",
  "data": {
    "customer_id": "cust_12345",
    "product": "Premium Plan",
    "amount": 99.99,
    "status": "pending",
    "metadata": {
      "referral": "twitter",
      "campaign": "spring2024"
    }
  }
}
```

## Response

On success, returns:

```json
{
  "success": true,
  "table": "users",
  "record": {
    "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "name": "Jane Doe",
    "email": "jane@example.com",
    "role": "customer",
    "created_at": "2024-01-15T10:30:00.000Z"
  },
  "record_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
}
```

## File Structure

```
supabase-insert-record/
├── run.xs                           # Run job configuration
├── functions/
│   └── supabase_insert_record.xs   # Main function logic
└── README.md                        # This file
```

## Error Handling

The run job includes comprehensive error handling:

- **Input Validation**: Checks that `table_name` and `data` are provided
- **API Errors**: Returns detailed error messages from Supabase if the insert fails
- **Missing Table**: You'll get a 404 error if the table doesn't exist
- **Schema Violations**: Returns PostgreSQL constraint errors (e.g., unique violations, not-null constraints)

## Prerequisites

1. A Supabase account and project
2. A table created in your Supabase database
3. The table must have proper RLS policies if you're using the service_role key
4. Xano environment variables configured with your Supabase credentials

## Setup in Xano

1. Copy these files to your Xano workspace
2. Set the environment variables (`supabase_url` and `supabase_service_key`)
3. Deploy the function and run job
4. Test with sample data

## See Also

- [Supabase Documentation](https://supabase.com/docs)
- [PostgREST Documentation](https://postgrest.org/)
- [Supabase JavaScript Client](https://supabase.com/docs/reference/javascript)
