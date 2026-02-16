run.job "Send Discord Webhook Message" {
  main = {
    name: "discord_webhook"
    input: {
      message: "🚀 Hello from Xano! This message was sent via a Discord webhook."
      username: "Xano Bot"
    }
  }
  env = ["discord_webhook_url"]
}
