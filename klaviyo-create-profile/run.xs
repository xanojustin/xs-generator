run.job "Klaviyo Create Profile" {
  main = {
    name: "create_profile"
    input: {
      email: "customer@example.com"
      first_name: "John"
      last_name: "Doe"
      phone: "+1234567890"
      event_name: "Signed Up"
    }
  }
  env = ["klaviyo_api_key"]
}
