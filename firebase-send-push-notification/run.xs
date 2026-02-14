run.job "Firebase Send Push Notification" {
  main = {
    name: "send_push_notification"
    input: {
      device_token: "sample_device_token_here"
      title: "Hello from Xano!"
      body: "This is a test push notification"
    }
  }
  env = ["FIREBASE_PROJECT_ID", "FIREBASE_SERVICE_ACCOUNT_KEY"]
}
