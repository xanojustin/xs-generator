# Courier Send Notification

A Xano Run Job that sends notifications using the Courier API across multiple channels (email, SMS, push, chat).

## What is Courier?

Courier is a notification infrastructure API that allows developers to design, send, and manage notifications across multiple channels with a single API call. It supports email (SendGrid, AWS SES, Mailgun, etc.), SMS (Twilio, MessageBird), push notifications (FCM, APNs), and chat (Slack, Discord, Microsoft Teams).

## What This Run Job Does

This run job sends a notification to a specified user using Courier's unified API. It supports:

- **Multi-channel delivery**: Send via email, SMS, push, or chat
- **Template-based messages**: Use Courier templates with dynamic data
- **User targeting**: Send to users by their unique ID
- **Brand customization**: Optional white-label support
- **Provider overrides**: Customize delivery settings per channel

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `COURIER_API_KEY` | Your Courier API key (get from https://app.courier.com/settings/api-keys) |

## How to Use

### Basic Usage

The run job is configured with sample input in `run.xs`:

```xs
run.job "Courier Send Notification" {
  main = {
    name: "send_notification"
    input: {
      user_id: "user_123"
      template: "welcome_email"
      channel: "email"
      data: {
        first_name: "John"
        company_name: "Acme Inc"
      }
    }
  }
  env = ["COURIER_API_KEY"]
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user_id` | text | Yes | Unique identifier for the recipient user |
| `template` | text | Yes | Courier template ID or event name |
| `channel` | text | No | Preferred channel: `email`, `sms`, `push`, or `chat` (default: `email`) |
| `data` | object | No | Dynamic data to populate template variables |
| `brand_id` | text | No | Brand ID for white-label notifications |
| `override` | object | No | Provider-specific overrides |

### Response

```json
{
  "success": true,
  "request_id": "1-5f3d7a30-1234567890abcdef",
  "status": "sent",
  "error": null
}
```

## Setting Up Courier

1. Sign up at https://app.courier.com
2. Create a notification template or use the default "welcome" template
3. Connect at least one provider (SendGrid, Twilio, etc.)
4. Get your API key from Settings → API Keys
5. Set the `COURIER_API_KEY` environment variable in Xano

## Example: Sending a Welcome Email

```xs
main = {
  name: "send_notification"
  input: {
    user_id: "user_456"
    template: "WELCOME_EMAIL"
    channel: "email"
    data: {
      first_name: "Sarah"
      company_name: "TechCorp"
      login_url: "https://app.example.com/login"
    }
  }
}
```

## Example: Sending an SMS

```xs
main = {
  name: "send_notification"
  input: {
    user_id: "user_789"
    template: "ORDER_SHIPPED_SMS"
    channel: "sms"
    data: {
      order_number: "ORD-12345"
      tracking_url: "https://track.example.com/12345"
    }
  }
}
```

## Files

- `run.xs` - Run job configuration
- `function/send_notification.xs` - Core function that calls Courier API

## API Documentation

For more details on the Courier API, visit: https://www.courier.com/docs/reference/
