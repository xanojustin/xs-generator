run.job "Google Sheets Append Row" {
  main = {
    name: "append_row"
    input: {
      spreadsheet_id: "your-spreadsheet-id"
      sheet_name: "Sheet1"
      values: ["John Doe", "john@example.com", "2024-01-15"]
    }
  }
  env = ["google_api_key"]
}
