function "supabase_insert_record" {
  description = "Insert a record into a Supabase PostgreSQL table via the PostgREST API"
  input {
    text table_name filters=trim { description = "Supabase table name to insert into" }
    json data { description = "Object containing the record data to insert" }
  }
  stack {
    precondition (($input.table_name|is_empty) == false) {
      error_type = "inputerror"
      error = "Table name is required"
    }

    precondition (($input.data|is_empty) == false) {
      error_type = "inputerror"
      error = "Data object is required"
    }

    var $api_url {
      value = $env.supabase_url ~ "/rest/v1/" ~ $input.table_name
    }

    api.request {
      url = $api_url
      method = "POST"
      headers = [
        "apikey: " ~ $env.supabase_service_key,
        "Authorization: Bearer " ~ $env.supabase_service_key,
        "Content-Type: application/json",
        "Prefer: return=representation"
      ]
      params = $input.data
    } as $insert_result

    var $response_status {
      value = $insert_result.response.status
    }

    precondition ($response_status == 201) {
      error_type = "standard"
      error = "Failed to insert record into Supabase: " ~ $insert_result.response.body|json_encode
    }

    var $inserted_record {
      value = $insert_result.response.body
    }

    var $record_id {
      value = $inserted_record|first|get:"id"
    }
  }
  response = {
    success: true,
    table: $input.table_name,
    record: $inserted_record|first,
    record_id: $record_id
  }
}
