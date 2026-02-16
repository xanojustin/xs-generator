run.job "RevenueCat Get Subscriber" {
  main = {
    name: "get_subscriber"
    input: {
      app_user_id: "user_12345"
    }
  }
  env = ["revenuecat_api_key"]
}
