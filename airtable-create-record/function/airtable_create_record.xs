function "airtable_create_record" {
  description = "Create a record in an Airtable base"
  input {
    text base_id { description = "Airtable Base ID (starts with 'app')" }
    text table_name { description = "Name or ID of the table" }
    json fields { description = "Record fields to create" }
  }
  stack {
    // Build the API URL
    var $api_url {
      value = "https://api.airtable.com/v0/" ~ $input.base_id ~ "/" ~ $input.table_name
    }

    // Build the request payload
    var $payload {
      value = {
        fields: $input.fields
      }
    }

    // Make the API request
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Authorization: Bearer " ~ $env.airtable_api_key,
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    // Handle response
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $record { value = $api_result.response.result }
      }
      else {
        throw {
          name = "AirtableAPIError"
          value = "Airtable API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $record
}
