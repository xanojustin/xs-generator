function "google_sheets_append_row" {
  description = "Append a row of data to a Google Sheets spreadsheet using the Google Sheets API"
  input {
    text spreadsheet_id filters=trim {
      description = "The ID of the Google Sheets spreadsheet (found in the URL)"
    }

    text sheet_name filters=trim {
      description = "The name of the worksheet/tab to append data to"
    }

    text[] values {
      description = "Array of values to append as a row"
    }

    text? value_input_option filters=trim|lower {
      description = "How the input should be interpreted: 'RAW' (raw values) or 'USER_ENTERED' (formulas/formatting). Defaults to 'USER_ENTERED'"
    }
  }

  stack {
    precondition (($input.spreadsheet_id|is_empty) == false) {
      error_type = "inputerror"
      error = "Spreadsheet ID is required"
    }

    precondition (($input.sheet_name|is_empty) == false) {
      error_type = "inputerror"
      error = "Sheet name is required"
    }

    precondition (($input.values|count) > 0) {
      error_type = "inputerror"
      error = "Values array must contain at least one value"
    }

    precondition (($env.google_access_token|is_empty) == false) {
      error_type = "inputerror"
      error = "Google access token environment variable (google_access_token) is required"
    }

    var $range {
      value = $input.sheet_name ~ "!A1"
      description = "The range to append to (sheet name with starting cell)"
    }

    var $input_option {
      value = ($input.value_input_option|is_empty) == false ? $input.value_input_option : "USER_ENTERED"
      description = "Value input option - defaults to USER_ENTERED"
    }

    var $request_body {
      value = {
        values: [$input.values]
      }
      description = "Request body with values array wrapped in another array for row format"
    }

    var $request_url {
      value = "https://sheets.googleapis.com/v4/spreadsheets/" ~ $input.spreadsheet_id ~ "/values/" ~ $range ~ ":append?valueInputOption=" ~ $input_option ~ "&insertDataOption=INSERT_ROWS"
      description = "Full Google Sheets API URL with query parameters"
    }

    api.request {
      description = "Call Google Sheets API to append the row"
      url = $request_url
      method = "POST"
      headers = [
        "Authorization: Bearer " ~ $env.google_access_token,
        "Content-Type: application/json"
      ]
      params = $request_body
    } as $api_response

    var $response_status {
      value = $api_response.response.status
      description = "HTTP status code from the API response"
    }

    precondition ($response_status == 200) {
      error_type = "standard"
      error = "Google Sheets API error: " ~ ($api_response.response.body.error|json_encode)
    }

    var $response_data {
      value = $api_response.response.body
      description = "Parsed response body from Google Sheets API"
    }
  }

  response = {
    success: true,
    spreadsheet_id: $input.spreadsheet_id,
    sheet_name: $input.sheet_name,
    updated_range: $response_data.updates.updatedRange,
    updated_rows: $response_data.updates.updatedRows,
    updated_cells: $response_data.updates.updatedCells,
    values_appended: $input.values
  }
}
