run.job "Send Slack Message" {
  main = {
    name: "send_slack_message"
    input: {
      channel: "#general"
      message: "Hello from Xano Run Job!"
    }
  }
  env = ["SLACK_BOT_TOKEN"]
}
