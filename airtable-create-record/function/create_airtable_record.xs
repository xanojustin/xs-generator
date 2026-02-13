function "create_airtable_record" {
  description = "Creates a new record in an Airtable base using the Airtable API"
  input {
    text base_id filters=trim
    text table_name filters=trim
    json fields
  }
  stack {
    // Validate required inputs
    precondition ($input.base_id != "") {
      error_type = "inputerror"
      error = "base_id is required"
    }
    
    precondition ($input.table_name != "") {
      error_type = "inputerror"
      error = "table_name is required"
    }
    
    precondition (`$input.fields|count > 0`) {
      error_type = "inputerror"
      error = "fields object must contain at least one field"
    }
    
    // Build the request payload
    var $payload {
      value = {
        fields: $input.fields
      }
    }
    
    // Make the API request to Airtable
    api.request {
      url = "https://api.airtable.com/v0/" ~ $input.base_id ~ "/" ~ $input.table_name
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.airtable_api_key
      ]
      params = $payload
      timeout = 30
    } as $api_result
    
    // Extract the created record
    var $created_record { value = $api_result.response.result }
  }
  response = $created_record
}
