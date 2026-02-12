run.job "Discord Send Message" {
  main = {
    name: "discord_send_message"
    input: {
      webhook_url: "https://discord.com/api/webhooks/000000000/xxxxxxxxxxxxxxxxxxxx"
      content: "Hello from Xano! This is a test message sent via Discord webhook."
      username: "Xano Bot"
      avatar_url: "https://cdn.xano.com/logo.png"
    }
  }
  env = ["discord_webhook_url"]
}
