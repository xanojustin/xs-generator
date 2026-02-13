run.job "Google Sheets Append Row" {
  main = {
    name: "google_sheets_append_row"
    input: {
      spreadsheet_id: "your-spreadsheet-id-here"
      sheet_name: "Sheet1"
      values: ["John Doe", "john@example.com", "2024-01-15", "Active"]
      value_input_option: "USER_ENTERED"
    }
  }
  env = ["google_access_token"]
}
