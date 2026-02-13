run.job "Slack Send Message" {
  main = {
    name: "send_slack_message"
    input: {}
  }
  env = ["slack_bot_token", "slack_channel", "slack_message"]
}
