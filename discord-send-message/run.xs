run.job "Discord Send Message" {
  main = {
    name: "send_discord_message"
    input: {
      content: "Hello from Xano! 🤖"
      username: "Xano Bot"
    }
  }
  env = ["DISCORD_WEBHOOK_URL"]
}
