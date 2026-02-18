run.job "Courier Send Notification" {
  main = {
    name: "send_courier_notification"
    input: {
      template_id: ""
      recipient_email: ""
      recipient_id: ""
      data: {}
    }
  }
  env = ["COURIER_AUTH_TOKEN"]
}
