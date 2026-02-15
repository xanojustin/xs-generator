run.job "ConvertKit Add Subscriber" {
  main = {
    name: "convertkit_add_subscriber"
    input: {
      email: "subscriber@example.com"
      first_name: "Subscriber"
      form_id: "123456"
    }
  }
  env = ["CONVERTKIT_API_KEY", "CONVERTKIT_API_SECRET"]
}
