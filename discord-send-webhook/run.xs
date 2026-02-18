run.job "Discord Send Webhook" {
  main = {
    name: "send_discord_webhook"
    input: {
      content: "Hello from Xano!"
      username: "Xano Bot"
      avatar_url: ""
    }
  }
  env = ["DISCORD_WEBHOOK_URL"]
}