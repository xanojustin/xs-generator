function "execute_sql" {
  description = "Execute a SQL query against a Neon serverless Postgres database"
  input {
    text query {
      description = "SQL query to execute"
    }
    text project_id {
      description = "Neon project ID (optional, uses env var if not provided)"
    }
    text database_name {
      description = "Database name (optional, uses env var if not provided)"
    }
    text branch_id {
      description = "Neon branch ID (optional, defaults to main)"
    }
  }
  stack {
    // Get configuration from environment variables or input
    var $neon_api_key {
      value = $env.neon_api_key
    }
    var $project_id {
      value = $input.project_id ?? $env.neon_project_id
    }
    var $database_name {
      value = $input.database_name ?? $env.neon_database_name ?? "neondb"
    }
    var $branch_id {
      value = $input.branch_id ?? "main"
    }

    // Validate required configuration
    precondition ($neon_api_key != null && $neon_api_key != "") {
      error_type = "inputerror"
      error = "Neon API key is required. Set neon_api_key environment variable."
    }

    precondition ($project_id != null && $project_id != "") {
      error_type = "inputerror"
      error = "Neon project ID is required. Set neon_project_id environment variable or provide as input."
    }

    // First, get the connection string for the branch
    api.request {
      url = "https://console.neon.tech/api/v2/projects/" ~ $project_id ~ "/branches/" ~ $branch_id
      method = "GET"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $neon_api_key
      ]
      timeout = 30
    } as $branch_result

    conditional {
      if ($branch_result.response.status != 200) {
        throw {
          name = "NeonAPIError"
          value = "Failed to get branch info: " ~ ($branch_result.response.status|to_text) ~ " - " ~ ($branch_result.response.result|json_encode)
        }
      }
    }

    // Get the first endpoint's host
    var $endpoint_host {
      value = $branch_result.response.result.endpoints|first|get:"host"
    }

    precondition ($endpoint_host != null && $endpoint_host != "") {
      error_type = "standard"
      error = "No compute endpoint found for branch: " ~ $branch_id
    }

    // Execute the SQL query using Neon's SQL endpoint
    // Note: Neon uses a connection string approach via their API
    api.request {
      url = "https://console.neon.tech/api/v2/projects/" ~ $project_id ~ "/query"
      method = "POST"
      params = {
        query: $input.query
      }
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $neon_api_key
      ]
      timeout = 60
    } as $query_result

    conditional {
      if ($query_result.response.status == 200) {
        var $rows {
          value = $query_result.response.result.rows ?? []
        }
        var $columns {
          value = $query_result.response.result.columns ?? []
        }
        var $row_count {
          value = $rows|count
        }
      }
      else {
        throw {
          name = "NeonQueryError"
          value = "Query failed: " ~ ($query_result.response.status|to_text) ~ " - " ~ ($query_result.response.result|json_encode)
        }
      }
    }
  }
  response = {
    success: true
    row_count: $row_count
    columns: $columns
    rows: $rows
    project_id: $project_id
    branch_id: $branch_id
    database: $database_name
  }
}
