run.job "Klaviyo Add Subscriber" {
  main = {
    name: "add_subscriber"
    input: {
      email: "subscriber@example.com"
      first_name: "John"
      last_name: "Doe"
      list_id: "YOUR_LIST_ID"
      phone_number: "+1234567890"
    }
  }
  env = ["KLAVIYO_API_KEY"]
}