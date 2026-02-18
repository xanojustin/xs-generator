run.job "Trigger Zapier Zap" {
  main = {
    name: "trigger_zap"
    input: {
      webhook_url: "https://hooks.zapier.com/hooks/catch/your/webhook/id"
      data: {}
    }
  }
  env = ["ZAPIER_WEBHOOK_URL"]
}
