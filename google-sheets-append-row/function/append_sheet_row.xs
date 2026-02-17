function "append_sheet_row" {
  description = "Append a row of data to a Google Sheet"
  input {
    text spreadsheet_id { description = "The ID of the Google Sheet (from the URL)" }
    text sheet_name { description = "The name of the worksheet/tab" }
    text[] values { description = "Array of values to append as a row" }
  }
  stack {
    precondition ($input.spreadsheet_id != "" && $input.spreadsheet_id != null) {
      error_type = "inputerror"
      error = "spreadsheet_id is required"
    }

    precondition (($input.values|count) > 0) {
      error_type = "inputerror"
      error = "values array cannot be empty"
    }

    var $range { value = $input.sheet_name ~ "!A1:Z" }

    var $payload {
      value = {
        values: [$input.values]
      }
    }

    var $url {
      value = "https://sheets.googleapis.com/v4/spreadsheets/" ~ $input.spreadsheet_id ~ "/values/" ~ $range ~ ":append?valueInputOption=USER_ENTERED"
    }

    api.request {
      url = $url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.google_access_token
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status == 200) {
        var $result { value = $api_result.response.result }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "GoogleAuthError"
          value = "Authentication failed. Check your google_access_token."
        }
      }
      elseif ($api_result.response.status == 403) {
        throw {
          name = "GooglePermissionError"
          value = "Permission denied. Ensure the Google Sheet is shared with the service account or user."
        }
      }
      elseif ($api_result.response.status == 404) {
        throw {
          name = "GoogleNotFoundError"
          value = "Spreadsheet not found. Check the spreadsheet_id."
        }
      }
      else {
        throw {
          name = "GoogleAPIError"
          value = "Google Sheets API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $result
}
