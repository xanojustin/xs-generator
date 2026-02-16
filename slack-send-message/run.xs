run.job "Slack Send Message" {
  main = {
    name: "send_slack_message"
    input: {
      channel: "#general"
      message: "Hello from Xano Run Job! This is an automated message sent via the Slack API."
    }
  }
  env = ["SLACK_BOT_TOKEN"]
}
