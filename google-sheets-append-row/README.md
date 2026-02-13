# Google Sheets Append Row Run Job

A XanoScript run job that appends a row of data to a Google Sheets spreadsheet using the Google Sheets API.

## What It Does

This run job appends a row of data to a specified Google Sheets worksheet. It's perfect for:
- Logging form submissions to a spreadsheet
- Recording transaction data
- Tracking user signups or events
- Building simple data pipelines from your app to Google Sheets

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `google_access_token` | A valid Google OAuth 2.0 access token with `https://www.googleapis.com/auth/spreadsheets` scope |

### Getting a Google Access Token

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the **Google Sheets API** (Library → Search "Google Sheets API" → Enable)
4. Go to **Credentials** → **Create Credentials** → **OAuth 2.0 Client ID**
5. Configure the OAuth consent screen if prompted
6. Choose **Application type**: "Web application" or "Desktop app"
7. Download the client credentials or use the OAuth 2.0 Playground to get an access token

**Quick token via OAuth 2.0 Playground:**
1. Go to [Google OAuth 2.0 Playground](https://developers.google.com/oauthplayground/)
2. Click the gear icon (settings) and check "Use your own OAuth credentials"
3. Enter your client ID and secret
4. Select scope: `https://www.googleapis.com/auth/spreadsheets`
5. Click "Authorize APIs" and exchange for tokens

## How to Use

### 1. Set the Environment Variable

```bash
export google_access_token="ya29.a0AfH6S..."
```

### 2. Find Your Spreadsheet ID

The spreadsheet ID is found in your Google Sheets URL:
```
https://docs.google.com/spreadsheets/d/{SPREADSHEET_ID}/edit
```

Example:
- URL: `https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit`
- Spreadsheet ID: `1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms`

### 3. Configure the Run Job

Edit the `input` block in `run.xs`:

```xs
run.job "Google Sheets Append Row" {
  main = {
    name: "google_sheets_append_row"
    input: {
      spreadsheet_id: "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"
      sheet_name: "Sheet1"
      values: ["John Doe", "john@example.com", "2024-01-15", "Active"]
      value_input_option: "USER_ENTERED"
    }
  }
  env = ["google_access_token"]
}
```

### 4. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `spreadsheet_id` | text | Yes | The ID of the Google Sheets spreadsheet (from the URL) |
| `sheet_name` | text | Yes | The name of the worksheet/tab to append data to (e.g., "Sheet1") |
| `values` | text[] | Yes | Array of string values to append as a single row |
| `value_input_option` | text | No | How to interpret the input: `"RAW"` (raw values) or `"USER_ENTERED"` (allows formulas/formatting). Default: `"USER_ENTERED"` |

### Value Input Options

- **`USER_ENTERED`** (default): Values are parsed as if the user typed them into the UI. Allows formulas (e.g., `=SUM(A1:A10)`), dates, and numbers.
- **`RAW`**: Values are stored as-is without parsing. Formulas are treated as plain text.

## File Structure

```
google-sheets-append-row/
├── run.xs                                  # Run job configuration
├── functions/
│   └── google_sheets_append_row.xs         # Function that calls Google Sheets API
└── README.md                               # This file
```

## API Reference

This implementation uses the Google Sheets API v4:

### Append Values Endpoint
- **Endpoint**: `POST https://sheets.googleapis.com/v4/spreadsheets/{spreadsheetId}/values/{range}:append`
- **Documentation**: https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values/append

### Required OAuth Scope
```
https://www.googleapis.com/auth/spreadsheets
```

## Response

On success, the function returns:

```json
{
  "success": true,
  "spreadsheet_id": "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms",
  "sheet_name": "Sheet1",
  "updated_range": "Sheet1!A5:D5",
  "updated_rows": 1,
  "updated_cells": 4,
  "values_appended": ["John Doe", "john@example.com", "2024-01-15", "Active"]
}
```

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing required fields (spreadsheet_id, sheet_name, values)
- Empty values array
- Missing environment variable (google_access_token)
- Google API errors (invalid token, spreadsheet not found, permission denied, etc.)

## Common Errors

| Error | Cause | Solution |
|-------|-------|----------|
| `401 Unauthorized` | Invalid or expired access token | Refresh your access token |
| `403 Forbidden` | Insufficient permissions | Ensure the spreadsheet is shared with the service account, or the OAuth scope includes spreadsheets |
| `404 Not Found` | Spreadsheet ID doesn't exist | Check the spreadsheet ID from the URL |
| `400 Bad Request` | Invalid sheet name | Verify the sheet name exists in the spreadsheet |

## Tips

- **Service Account**: For production use, consider using a Google Service Account instead of OAuth user tokens
- **Token Refresh**: Access tokens expire after ~1 hour. Implement token refresh logic for long-running applications
- **Rate Limits**: Google Sheets API has quota limits. See [Google's quota documentation](https://developers.google.com/sheets/api/limits)

## License

MIT
