# Google Sheets Append Row

This Xano run job appends a row of data to a Google Sheets spreadsheet using the Google Sheets API.

## What It Does

The run job makes an authenticated API call to Google Sheets to append a new row of data to a specified spreadsheet and sheet/tab. It's useful for:

- Logging form submissions to a spreadsheet
- Recording analytics or events
- Building simple data collection workflows
- Syncing data to Google Sheets for reporting

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `google_api_key` | Your Google Cloud API key with Google Sheets API enabled |

### Setting Up Your Google API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the **Google Sheets API**:
   - Navigate to "APIs & Services" > "Library"
   - Search for "Google Sheets API"
   - Click "Enable"
4. Create an API key:
   - Navigate to "APIs & Services" > "Credentials"
   - Click "Create Credentials" > "API Key"
   - Copy the generated key
5. (Optional) Restrict the API key for security:
   - Click on the API key
   - Under "API restrictions", select "Google Sheets API"

### Spreadsheet Access Requirements

- The spreadsheet must be **publicly accessible** OR
- The Google Cloud project must have access to the sheet
- For private sheets, you may need OAuth2 authentication instead of an API key

## How to Use

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `spreadsheet_id` | text | Yes | The ID of the spreadsheet (found in the URL between `/d/` and `/edit`) |
| `sheet_name` | text | No | The name of the sheet/tab (default: "Sheet1") |
| `values` | text[] | Yes | Array of values to append as a new row |

### Example Input

```json
{
  "spreadsheet_id": "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms",
  "sheet_name": "Leads",
  "values": ["John Doe", "john@example.com", "2024-01-15", "Website Form"]
}
```

### Finding Your Spreadsheet ID

The spreadsheet ID is the long string in the URL:

```
https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                           This is your spreadsheet ID
```

### Response

**Success (200):**
```json
{
  "success": true,
  "message": "Row appended successfully",
  "spreadsheetId": "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms",
  "tableRange": "Leads!A1:D1",
  "updates": {
    "updatedRange": "Leads!A2:D2",
    "updatedRows": 1,
    "updatedColumns": 4,
    "updatedCells": 4
  }
}
```

**Error (various):**
```json
{
  "success": false,
  "error": "Description of what went wrong"
}
```

## Folder Structure

```
google-sheets-append-row/
├── run.xs              # Run job configuration
├── function/
│   └── append_row.xs   # Main function logic
└── README.md           # This file
```

## Running the Job

Execute via the Xano Job Runner or CLI:

```bash
xano run execute google-sheets-append-row
```

Or use the Xano dashboard to trigger the run job manually with custom inputs.

## Limitations

- This implementation uses API key authentication, which only works with publicly accessible spreadsheets
- For private spreadsheets, OAuth2 authentication is required (more complex setup)
- API has rate limits: 300 requests per minute per project (can be increased)
- Each request appends one row; for bulk operations, consider batching

## Resources

- [Google Sheets API Documentation](https://developers.google.com/sheets/api)
- [Google Cloud Console](https://console.cloud.google.com/)
