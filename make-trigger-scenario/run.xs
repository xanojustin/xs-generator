run.job "Trigger Make Scenario" {
  main = {
    name: "trigger_make_scenario"
    input: {
      scenario_name: "xano-data-sync"
      payload: {
        event: "user_signup"
        user_id: 12345
        email: "user@example.com"
        plan: "premium"
      }
    }
  }
  env = ["make_webhook_url"]
}
