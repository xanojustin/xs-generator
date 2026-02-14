function "append_row" {
  description = "Append a row of data to a Google Sheets spreadsheet using the Google Sheets API"
  input {
    text spreadsheet_id filters=trim {
      description = "The ID of the Google Sheets spreadsheet (found in the URL)"
    }
    text sheet_name?="Sheet1" filters=trim {
      description = "The name of the sheet/tab to append to (default: Sheet1)"
    }
    text[] values {
      description = "Array of values to append as a new row"
    }
  }
  stack {
    // Build the API URL
    var $range {
      value = $input.sheet_name ~ "!A1:Z"
    }
    
    var $api_url {
      value = "https://sheets.googleapis.com/v4/spreadsheets/" ~ $input.spreadsheet_id ~ "/values/" ~ ($range|url_encode) ~ ":append"
    }
    
    // Build query parameters
    var $query_params {
      value = "?valueInputOption=USER_ENTERED&insertDataOption=INSERT_ROWS&key=" ~ $env.google_api_key
    }
    
    // Full URL with query params
    var $full_url {
      value = $api_url ~ $query_params
    }
    
    // Build request body
    var $request_body {
      value = {
        range: $range,
        majorDimension: "ROWS",
        values: [$input.values]
      }
    }
    
    // Make the API request
    api.request {
      url = $full_url
      method = "POST"
      params = $request_body
      headers = ["Content-Type: application/json"]
      timeout = 30
    } as $api_result
    
    // Check response status
    conditional {
      if ($api_result.response.status == 200) {
        var $result {
          value = {
            success: true,
            message: "Row appended successfully",
            spreadsheetId: $api_result.response.result.spreadsheetId,
            tableRange: $api_result.response.result.tableRange,
            updates: $api_result.response.result.updates
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        var $result {
          value = {
            success: false,
            error: "Invalid request: " ~ ($api_result.response.result|json_encode)
          }
        }
      }
      elseif ($api_result.response.status == 401 || $api_result.response.status == 403) {
        var $result {
          value = {
            success: false,
            error: "Authentication failed. Check your Google API key."
          }
        }
      }
      elseif ($api_result.response.status == 404) {
        var $result {
          value = {
            success: false,
            error: "Spreadsheet not found. Check the spreadsheet ID."
          }
        }
      }
      else {
        var $result {
          value = {
            success: false,
            error: "API error (status " ~ ($api_result.response.status|to_text) ~ "): " ~ ($api_result.response.result|json_encode)
          }
        }
      }
    }
  }
  response = $result
}
