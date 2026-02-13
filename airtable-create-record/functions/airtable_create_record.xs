function "airtable_create_record" {
  description = "Create a new record in an Airtable base"
  input {
    text base_id filters=trim {
      description = "Airtable Base ID (starts with 'app')"
    }
    text table_name filters=trim {
      description = "Table name or table ID (starts with 'tbl')"
    }
    json fields {
      description = "Object containing field values for the new record"
    }
  }
  stack {
    precondition (($input.base_id|is_empty) == false) {
      error_type = "inputerror"
      error = "Airtable Base ID is required"
    }

    precondition (($input.table_name|is_empty) == false) {
      error_type = "inputerror"
      error = "Table name or ID is required"
    }

    var $fields_count {
      value = $input.fields|count
    }

    precondition ($fields_count > 0) {
      error_type = "inputerror"
      error = "At least one field must be provided to create a record"
    }

    var $api_url {
      value = "https://api.airtable.com/v0/" ~ $input.base_id ~ "/" ~ $input.table_name
    }

    var $request_body {
      value = {
        fields: $input.fields
      }
    }

    debug.log {
      value = "Creating Airtable record in base: " ~ $input.base_id ~ ", table: " ~ $input.table_name
      description = "Log Airtable API request"
    }

    api.request {
      url = $api_url
      method = "POST"
      headers = [
        "Authorization: Bearer " ~ $env.airtable_api_key,
        "Content-Type: application/json"
      ]
      params = $request_body
    } as $api_response

    var $response_status {
      value = $api_response.response.status
    }

    conditional {
      description = "Handle API errors"
      if ($response_status != 200) {
        var $error_message {
          value = $api_response.response.body.error|get:"message":"Unknown Airtable API error"
        }
        
        throw {
          name = "airtable_api_error"
          value = "Airtable API error (" ~ $response_status ~ "): " ~ $error_message
        }
      }
    }

    var $record {
      value = $api_response.response.body
    }

    debug.log {
      value = "Successfully created Airtable record with ID: " ~ $record.id
      description = "Log successful record creation"
    }
  }
  response = {
    success: true,
    record_id: $record.id,
    created_time: $record.createdTime,
    fields: $record.fields
  }
}