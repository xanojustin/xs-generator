function "supabase_insert" {
  description = "Insert a record into a Supabase table via REST API"
  input {
    text table_name filters=trim
    json data
  }
  stack {
    // Validate required environment variables
    precondition ($env.supabase_url != null && $env.supabase_url != "") {
      error_type = "standard"
      error = "SUPABASE_URL environment variable is required"
    }

    precondition ($env.supabase_anon_key != null && $env.supabase_anon_key != "") {
      error_type = "standard"
      error = "SUPABASE_ANON_KEY environment variable is required"
    }

    // Build the Supabase REST API URL
    var $api_url {
      value = $env.supabase_url ~ "/rest/v1/" ~ $input.table_name
    }

    // Make the POST request to Supabase
    api.request {
      url = $api_url
      method = "POST"
      params = $input.data
      headers = [
        "Content-Type: application/json",
        "apikey: " ~ $env.supabase_anon_key,
        "Authorization: Bearer " ~ $env.supabase_anon_key
      ]
      timeout = 30
    } as $api_result

    // Check for successful response (201 Created for insert)
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $result {
          value = {
            success: true,
            status: $api_result.response.status,
            data: $api_result.response.result
          }
        }
      }
      else {
        var $result {
          value = {
            success: false,
            status: $api_result.response.status,
            error: $api_result.response.result
          }
        }
      }
    }
  }
  response = $result
}
