# Firebase Send Push Notification

A Xano Run Job that sends push notifications to mobile devices using Firebase Cloud Messaging (FCM) v1 API.

## What This Run Job Does

This run job sends push notifications to Android and iOS devices via Firebase Cloud Messaging. It supports:

- **Basic notifications** with title and body
- **Rich notifications** with images
- **Custom data payloads** for handling in-app actions
- **FCM v1 API** (the modern, recommended API)

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `FIREBASE_PROJECT_ID` | Your Firebase project ID | Found in Firebase Console → Project Settings → General |
| `FIREBASE_SERVICE_ACCOUNT_KEY` | OAuth2 access token or service account key | Generated via Firebase Admin SDK or OAuth2 flow |

### Setting Up Firebase Service Account

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Go to Project Settings → Service Accounts
4. Click "Generate new private key"
5. Store the JSON credentials securely
6. Use the credentials to generate an OAuth2 access token for the FCM API

## How to Use

### Run the Job

```bash
cd ~/xs/firebase-send-push-notification
xano run run.xs
```

### Modify Input Parameters

Edit `run.xs` to customize the notification:

```xs
run.job "Firebase Send Push Notification" {
  main = {
    name: "send_push_notification"
    input: {
      device_token: "YOUR_DEVICE_TOKEN_HERE"
      title: "My Custom Title"
      body: "My custom notification message"
      image_url: "https://example.com/image.png"  // Optional
      data: {                                     // Optional custom data
        action: "open_screen",
        screen: "profile",
        user_id: "12345"
      }
    }
  }
  env = ["FIREBASE_PROJECT_ID", "FIREBASE_SERVICE_ACCOUNT_KEY"]
}
```

### Function Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `device_token` | string | Yes | FCM device registration token |
| `title` | string | Yes | Notification title |
| `body` | string | Yes | Notification body text |
| `image_url` | string | No | URL for notification image |
| `data` | object | No | Custom key-value data payload |

## File Structure

```
firebase-send-push-notification/
├── run.xs                           # Run job configuration
├── function/
│   └── send_push_notification.xs    # Main function
└── README.md                        # This file
```

## Response Format

On success, the function returns:

```json
{
  "success": true,
  "message_id": "projects/my-project/messages/0:1234567890%1234567890",
  "status": 200,
  "device_token": "abc123..."
}
```

## Important Notes

1. **OAuth2 Token**: This example assumes you have a valid OAuth2 access token. In production, implement proper token refresh logic using the service account credentials.

2. **Device Token**: The device token must be obtained from the Firebase SDK on the client device (Android/iOS app).

3. **FCM v1 vs Legacy**: This uses the FCM v1 API (recommended). The legacy API is deprecated.

4. **Error Handling**: The function validates inputs and API responses with descriptive error messages.

## Resources

- [FCM Documentation](https://firebase.google.com/docs/cloud-messaging)
- [FCM v1 API Reference](https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages)
- [Firebase Console](https://console.firebase.google.com/)
