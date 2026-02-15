run.job "Send Telegram Message" {
  main = {
    name: "send_telegram_message"
    input: {
      chat_id: "@your_channel_or_chat_id"
      message: "Hello from Xano Run Job! 🤖"
      parse_mode: "HTML"
      disable_notification: false
    }
  }
  env = ["telegram_bot_token"]
}
