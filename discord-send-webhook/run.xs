run.job "Send Discord Webhook" {
  main = {
    name: "send_discord_webhook"
    input: {
      content: "🚀 Hello from XanoScript!"
      username: "Xano Bot"
      title: "Xano Run Job Complete"
      description: "Your Discord webhook integration is working perfectly! This message was sent via Xano Run Jobs."
      color: "3447003"
      footer_text: "Powered by Xano"
    }
  }
  env = ["discord_webhook_url"]
}