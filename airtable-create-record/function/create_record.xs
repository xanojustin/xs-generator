function "create_record" {
  description = "Create a record in an Airtable base"
  input {
    text base_id filters=trim { description = "Airtable base ID (e.g., app1234567890abcd)" }
    text table_name filters=trim { description = "Table name or ID (e.g., Tasks or tbl1234567890abcd)" }
    text fields filters=trim { description = "JSON string containing field names and values for the new record" }
    text typecast? filters=trim { description = "Typecast option - set to true to coerce type mismatches (optional)" }
  }

  stack {
    var $api_key { value = $env.AIRTABLE_API_KEY }

    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "AIRTABLE_API_KEY environment variable not configured"
    }

    precondition ($input.base_id != null && $input.base_id != "") {
      error_type = "inputerror"
      error = "base_id is required"
    }

    precondition ($input.table_name != null && $input.table_name != "") {
      error_type = "inputerror"
      error = "table_name is required"
    }

    precondition ($input.fields != null && $input.fields != "") {
      error_type = "inputerror"
      error = "fields is required"
    }

    var $fields_obj { value = $input.fields|json_decode }

    precondition ($fields_obj != null) {
      error_type = "inputerror"
      error = "fields must be valid JSON"
    }

    var $payload {
      value = {
        fields: $fields_obj
      }
    }

    conditional {
      if ($input.typecast != null && $input.typecast == "true") {
        var.update $payload {
          value = $payload|set:"typecast":true
        }
      }
    }

    var $api_url {
      value = "https://api.airtable.com/v0/" ~ $input.base_id ~ "/" ~ $input.table_name
    }

    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
      timeout = 30
    } as $api_result

    var $success { value = false }
    var $record_id { value = null }
    var $created_record { value = null }
    var $error_message { value = null }

    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $created_record { value = $response_body }
        var $record_id { value = $response_body|get:"id" }
      }
      elseif ($api_result.response.status == 400) {
        var $success { value = false }
        var $error_message { value = "Bad request - check your field names and values" }
      }
      elseif ($api_result.response.status == 401) {
        var $success { value = false }
        var $error_message { value = "Unauthorized - check your AIRTABLE_API_KEY" }
      }
      elseif ($api_result.response.status == 403) {
        var $success { value = false }
        var $error_message { value = "Forbidden - you do not have permission to create records in this base" }
      }
      elseif ($api_result.response.status == 404) {
        var $success { value = false }
        var $error_message { value = "Not found - check your base_id and table_name" }
      }
      elseif ($api_result.response.status == 422) {
        var $success { value = false }
        var $error_message { value = "Validation failed - check your field values match expected types" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Airtable API error: HTTP " ~ ($api_result.response.status|to_text)
        }
      }
    }
  }

  response = {
    success: $success,
    record_id: $record_id,
    record: $created_record,
    error: $error_message
  }
}
