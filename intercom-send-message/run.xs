run.job "Send Intercom Message" {
  main = {
    name: "intercom_send_message"
    input: {
      user_id: ""
      message_body: ""
      message_type: "email"
    }
  }
  env = ["INTERCOM_ACCESS_TOKEN", "INTERCOM_ADMIN_ID"]
}
