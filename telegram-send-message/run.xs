run.job "Send Telegram Message" {
  main = {
    name: "send_telegram_message"
    input: {
      chat_id: "7984772893"
      message: "Hello from Xano Run Job!"
    }
  }
  env = ["telegram_bot_token"]
}
