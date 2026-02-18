run.job "Slack Post Message" {
  main = {
    name: "post_message"
    input: {
      channel: "#general"
      message: "Hello from Xano!"
      username: "Xano Bot"
      icon_emoji: ":robot_face:"
    }
  }
  env = ["SLACK_BOT_TOKEN"]
}
