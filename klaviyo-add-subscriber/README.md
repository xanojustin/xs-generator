# Klaviyo Add Subscriber - Xano Run Job

This Xano Run Job adds a subscriber/profile to a Klaviyo list.

## What It Does

This run job creates or updates a Klaviyo profile and adds it to a specified list. It:

1. Validates input parameters (email and list_id must be present)
2. Creates or updates a profile via Klaviyo's Profile Import API (`POST /api/profile-import`)
3. Adds the profile to the specified list (`POST /api/lists/{list_id}/relationships/profiles`)
4. Logs the result to a local `subscriber_log` table (success or failure)
5. Returns detailed subscriber information on success, or throws an error on failure

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `KLAVIYO_API_KEY` | Your Klaviyo private API key (starts with `pk_`) |

Get your API key from: https://www.klaviyo.com/settings/account/api-keys

## How to Use

### Running the Job

```bash
# Via Xano CLI
xano run run.xs --env KLAVIYO_API_KEY=pk_...

# Or set the env var first
export KLAVIYO_API_KEY=pk_...
xano run run.xs
```

### Customizing the Input

Edit `run.xs` to change the default input values:

```xs
run.job "Klaviyo Add Subscriber" {
  main = {
    name: "add_subscriber"
    input: {
      email: "customer@example.com"       // Subscriber's email address
      first_name: "Jane"                   // Optional: First name
      last_name: "Smith"                   // Optional: Last name
      list_id: "YOUR_LIST_ID"              // Klaviyo list ID to add subscriber to
      phone_number: "+1234567890"          // Optional: Phone number for SMS
    }
  }
  env = ["KLAVIYO_API_KEY"]
}
```

### Calling the Function Directly

You can also call the `add_subscriber` function from other XanoScript code:

```xs
function "process_signup" {
  input {
    text email
    text first_name
    text list_id
  }
  stack {
    // Call the add subscriber function
    function add_subscriber {
      input = {
        email: $input.email,
        first_name: $input.first_name,
        list_id: $input.list_id
      }
    } as $subscriber_result
  }
  response = $subscriber_result
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `email` | text | Yes | - | Subscriber's email address |
| `first_name` | text | No | `""` | Optional first name |
| `last_name` | text | No | `""` | Optional last name |
| `list_id` | text | Yes | - | Klaviyo list ID to add the subscriber to |
| `phone_number` | text | No | `""` | Optional phone number for SMS marketing |

## Response

On success, returns:

```json
{
  "success": true,
  "profile_id": "01H...",
  "email": "customer@example.com",
  "list_id": "YOUR_LIST_ID",
  "first_name": "Jane",
  "last_name": "Smith",
  "phone_number": "+1234567890",
  "added_to_list": true
}
```

## Error Handling

The job handles these error scenarios:

- **Input validation errors** (400): Missing email or list_id
- **Klaviyo API errors** (4xx/5xx): Invalid API key, invalid list ID, rate limiting
- **Profile creation failures**: Email format issues, duplicate profile conflicts

All attempts (success or failure) are logged to the `subscriber_log` table.

## File Structure

```
~/xs/klaviyo-add-subscriber/
├── run.xs                          # Run job definition
├── function/
│   └── add_subscriber.xs           # Main subscriber function
├── table/
│   └── subscriber_log.xs           # Table for logging subscriptions
└── README.md                       # This file
```

## Testing

For testing, you can create a test list in Klaviyo:

1. Go to Lists & Segments in Klaviyo
2. Create a new list
3. Copy the List ID from the URL or list settings
4. Use this ID in your test calls

Test with example.com emails to avoid affecting real subscribers.

## Security Notes

- Never commit your `KLAVIYO_API_KEY` to version control
- Use environment variables or Xano's secret management
- The job validates inputs before calling Klaviyo
- All subscription attempts are logged for audit purposes
- Consider implementing double opt-in for production use

## Links

- [Klaviyo API Docs](https://developers.klaviyo.com/en/reference/create_or_update_profile)
- [Klaviyo List API](https://developers.klaviyo.com/en/reference/add_profiles_to_list)
- [Klaviyo Developer Portal](https://developers.klaviyo.com/)