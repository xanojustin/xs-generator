run.job "Google Sheets Append Row" {
  main = {
    name: "append_sheet_row"
    input: {
      spreadsheet_id: "YOUR_SPREADSHEET_ID_HERE"
      sheet_name: "Sheet1"
      values: ["Timestamp", "Example Data", "123", "Complete"]
    }
  }
  env = ["google_access_token"]
}
