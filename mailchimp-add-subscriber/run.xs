run.job "Mailchimp Add Subscriber" {
  main = {
    name: "mailchimp_add_subscriber"
    input: {
      email: "test@example.com"
      first_name: "Test"
      last_name: "User"
      audience_id: ""
    }
  }
  env = ["mailchimp_api_key", "mailchimp_server_prefix"]
}