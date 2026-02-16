# Neon Execute SQL Run Job

Execute SQL queries against a Neon serverless Postgres database using the Xano Job Runner.

## What It Does

This run job connects to your Neon serverless Postgres database and executes SQL queries, returning the results in a structured format. It supports querying data, running analytics, or performing database maintenance tasks.

## Features

- Execute any SQL query against your Neon database
- Automatic branch selection (defaults to `main`)
- Environment variable configuration for security
- Input validation with clear error messages
- Returns row count, columns, and data rows

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `neon_api_key` | Your Neon API key (get from Neon Console → Settings → API Keys) |
| `neon_project_id` | Your Neon project ID (found in project settings) |
| `neon_database_name` | (Optional) Database name, defaults to `neondb` |

## Optional Input Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `query` | text | The SQL query to execute (default: `SELECT * FROM users LIMIT 10`) |
| `project_id` | text | Neon project ID (overrides env var) |
| `database_name` | text | Database name (overrides env var) |
| `branch_id` | text | Neon branch ID (default: `main`) |

## Usage

### Basic Usage (with defaults)

```xs
run.job "Neon Execute SQL" {
  main = {
    name: "execute_sql"
    input: {}
  }
  env = ["neon_api_key", "neon_project_id", "neon_database_name"]
}
```

### Execute Custom Query

```xs
run.job "Get Recent Users" {
  main = {
    name: "execute_sql"
    input: {
      query: "SELECT id, email, created_at FROM users WHERE created_at > NOW() - INTERVAL '7 days' ORDER BY created_at DESC"
    }
  }
  env = ["neon_api_key", "neon_project_id"]
}
```

### Query Specific Branch

```xs
run.job "Query Dev Branch" {
  main = {
    name: "execute_sql"
    input: {
      query: "SELECT COUNT(*) as total_users FROM users"
      branch_id: "dev-branch-123"
    }
  }
  env = ["neon_api_key", "neon_project_id"]
}
```

## Response Format

```json
{
  "success": true,
  "row_count": 10,
  "columns": ["id", "email", "created_at"],
  "rows": [
    {"id": 1, "email": "user1@example.com", "created_at": "2024-01-15T10:30:00Z"},
    {"id": 2, "email": "user2@example.com", "created_at": "2024-01-16T14:20:00Z"}
  ],
  "project_id": "your-project-id",
  "branch_id": "main",
  "database": "neondb"
}
```

## Error Handling

The job handles various error scenarios:

- **Missing API Key**: Returns `inputerror` if `neon_api_key` is not set
- **Missing Project ID**: Returns `inputerror` if `neon_project_id` is not set
- **Invalid Branch**: Throws `NeonAPIError` if branch doesn't exist
- **No Compute Endpoint**: Returns error if branch has no active compute
- **Query Errors**: Throws `NeonQueryError` with details on SQL errors

## API Reference

This run job uses the Neon API:
- **Base URL**: `https://console.neon.tech/api/v2`
- **Authentication**: Bearer token via `Authorization` header
- **Documentation**: https://api-docs.neon.tech/

## Security Notes

- Never hardcode your Neon API key in the code
- Always use environment variables for sensitive credentials
- Consider using read-only database roles for queries
- Restrict API key permissions in Neon Console

## Files

- `run.xs` - Run job configuration
- `function/execute_sql.xs` - Main function that executes SQL queries
