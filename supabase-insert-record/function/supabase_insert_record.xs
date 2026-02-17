function "supabase_insert_record" {
  description = "Insert a record into a Supabase table using the REST API"
  input {
    text table { description = "Name of the Supabase table" }
    json data { description = "Object containing the data to insert" }
    text conflict_resolution?="error" { description = "How to handle conflicts: 'error', 'ignore', or 'update'" }
    text[] returning_columns? { description = "Columns to return after insert (defaults to all)" }
  }
  
  stack {
    // Validate required inputs
    precondition ($input.table != "") {
      error_type = "inputerror"
      error = "Table name is required"
    }
    
    precondition (($input.data|count) > 0) {
      error_type = "inputerror"
      error = "Data object must contain at least one field"
    }
    
    // Get Supabase credentials from environment
    var $supabase_url { value = $env.SUPABASE_URL }
    var $supabase_anon_key { value = $env.SUPABASE_ANON_KEY }
    var $supabase_service_key { value = $env.SUPABASE_SERVICE_ROLE_KEY }
    
    // Use service role key if available, otherwise use anon key
    var $api_key { value = $supabase_service_key }
    conditional {
      if ($supabase_service_key == null || $supabase_service_key == "") {
        var $api_key { value = $supabase_anon_key }
      }
    }
    
    precondition ($supabase_url != null && $supabase_url != "") {
      error_type = "standard"
      error = "SUPABASE_URL environment variable is required"
    }
    
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "Either SUPABASE_ANON_KEY or SUPABASE_SERVICE_ROLE_KEY environment variable is required"
    }
    
    // Build headers array
    var $headers_base {
      value = [
        "Content-Type: application/json",
        "apikey: " ~ $api_key,
        "Authorization: Bearer " ~ $api_key
      ]
    }
    
    // Build the URL
    var $url { value = $supabase_url ~ "/rest/v1/" ~ $input.table }
    
    // Add columns parameter if returning_columns specified
    conditional {
      if ($input.returning_columns != null && ($input.returning_columns|count) > 0) {
        var $columns { value = $input.returning_columns|join:"," }
        var $url { value = $url ~ "?columns=" ~ ($columns|url_encode) }
      }
    }
    
    // Determine prefer header based on conflict resolution
    var $prefer_value { value = "return=representation" }
    
    conditional {
      if ($input.conflict_resolution == "ignore") {
        var $prefer_value { value = "resolution=ignore-duplicates,return=representation" }
      }
      elseif ($input.conflict_resolution == "update") {
        var $prefer_value { value = "resolution=merge-duplicates,return=representation" }
      }
    }
    
    var $headers {
      value = $headers_base|push:("Prefer: " ~ $prefer_value)
    }
    
    debug.log { value = "Inserting record into Supabase table: " ~ $input.table }
    
    // Make the API request to Supabase
    api.request {
      url = $url
      method = "POST"
      params = $input.data
      headers = $headers
      timeout = 30
    } as $api_result
    
    debug.log { value = "Supabase response status: " ~ ($api_result.response.status|to_text) }
    
    // Handle the response
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $insert_result {
          value = {
            success: true,
            table: $input.table,
            data: $api_result.response.result
          }
        }
      }
      elseif ($api_result.response.status == 409) {
        throw {
          name = "SupabaseConflictError"
          value = "Record already exists (conflict): " ~ ($api_result.response.result|json_encode)
        }
      }
      else {
        throw {
          name = "SupabaseAPIError"
          value = "Supabase API error (status " ~ ($api_result.response.status|to_text) ~ "): " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  
  response = $insert_result
}
