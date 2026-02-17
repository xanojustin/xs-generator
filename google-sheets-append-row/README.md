# Google Sheets Append Row - Xano Run Job

This Xano Run Job appends a row of data to a Google Sheet using the Google Sheets API. It demonstrates how to integrate with Google Sheets from Xano for data logging, form submissions, or any automated data entry needs.

## What This Run Job Does

The `Google Sheets Append Row` run job:
1. Takes a spreadsheet ID, sheet name, and array of values
2. Authenticates with Google using an OAuth 2.0 access token
3. Appends the values as a new row at the end of the specified sheet
4. Returns the API response with details about the update

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `google_access_token` | OAuth 2.0 access token for Google Sheets API | See [Getting an Access Token](#getting-an-access-token) below |

## Getting an Access Token

### Option 1: Google OAuth 2.0 Playground (Quick Testing)

1. Go to [Google OAuth 2.0 Playground](https://developers.google.com/oauthplayground)
2. Click the gear icon (⚙️) and check "Use your own OAuth credentials"
3. Enter your OAuth 2.0 Client ID and Secret (from Google Cloud Console)
4. Select scope: `https://www.googleapis.com/auth/spreadsheets`
5. Click "Authorize APIs" and complete the OAuth flow
6. Click "Exchange authorization code for tokens"
7. Copy the **Access token** (expires in 1 hour)

### Option 2: Service Account (Production)

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable the Google Sheets API: APIs & Services → Library → Google Sheets API → Enable
4. Create credentials: APIs & Services → Credentials → Create Credentials → Service Account
5. Download the JSON key file
6. Share your Google Sheet with the service account email (found in the JSON file)
7. Use the service account to generate access tokens via OAuth 2.0 JWT flow

### Option 3: Refresh Token (Long-term)

For long-term access without manual token refresh:

1. Complete Option 1 to get a refresh token
2. Store the refresh token in your environment
3. Use a separate function to exchange the refresh token for a new access token before calling this job

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Google Sheets Append Row"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Google Sheets Append Row"
}
```

### Customizing the Data

Edit the `input` block in `run.xs`:

```xs
run.job "Google Sheets Append Row" {
  main = {
    name: "append_sheet_row"
    input: {
      spreadsheet_id: "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"
      sheet_name: "Orders"
      values: [
        "2024-01-15 10:30:00",
        "Order #12345",
        "John Doe",
        "$99.99",
        "Pending"
      ]
    }
  }
  env = ["google_access_token"]
}
```

### Finding Your Spreadsheet ID

The spreadsheet ID is found in the Google Sheets URL:

```
https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
                    └─────────────────────────────────────────────────────────────┘
                                    This is your spreadsheet ID
```

## File Structure

```
google-sheets-append-row/
├── run.xs                       # Run job configuration
├── function/
│   └── append_sheet_row.xs      # Function that calls Google Sheets API
├── README.md                    # This file
└── FEEDBACK.md                  # Development feedback for MCP improvements
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `spreadsheet_id` | text | Yes | The Google Sheet ID from the URL |
| `sheet_name` | text | Yes | The name of the worksheet/tab (e.g., "Sheet1") |
| `values` | text[] | Yes | Array of text values to append as a row |

## Response Format

On success, the function returns a Google Sheets API response:

```json
{
  "spreadsheetId": "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms",
  "tableRange": "Sheet1!A1:D4",
  "updates": {
    "updatedRange": "Sheet1!A5:D5",
    "updatedRows": 1,
    "updatedColumns": 4,
    "updatedCells": 4
  }
}
```

## Error Handling

The function throws specific errors for common issues:

| Error | Cause | Solution |
|-------|-------|----------|
| `GoogleAuthError` (401) | Invalid or expired access token | Refresh your access token |
| `GooglePermissionError` (403) | No write access to sheet | Share the sheet with edit permissions |
| `GoogleNotFoundError` (404) | Spreadsheet ID doesn't exist | Check the spreadsheet ID |
| `GoogleAPIError` | Other API errors | Check the error message for details |

## Use Cases

- **Form submissions**: Log contact form entries to a spreadsheet
- **Order tracking**: Append new orders from your e-commerce system
- **Audit logs**: Track user actions or system events
- **Data exports**: Accumulate data from various sources
- **Reporting**: Build datasets for analytics and dashboards

## Example: Dynamic Timestamp

To always append the current timestamp:

```xs
// In your run.xs or calling function
var $timestamp { value = now|format_timestamp:"Y-m-d H:i:s":"UTC" }

input: {
  spreadsheet_id: "YOUR_ID"
  sheet_name: "Logs"
  values: [
    $timestamp,
    "User Action",
    "Details here"
  ]
}
```

## Security Notes

- **Never commit your access token** - always use environment variables
- Access tokens expire (typically after 1 hour) - implement refresh token flow for production
- Share Google Sheets with appropriate permissions (view vs edit)
- Use service accounts for server-to-server authentication
- Consider implementing token refresh logic in a separate function

## Additional Resources

- [Google Sheets API Documentation](https://developers.google.com/sheets/api)
- [Google Sheets API - Append Values](https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values/append)
- [Google OAuth 2.0 Documentation](https://developers.google.com/identity/protocols/oauth2)
- [XanoScript Documentation](https://docs.xano.com)
