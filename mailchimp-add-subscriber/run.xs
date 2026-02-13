run.job "Mailchimp Add Subscriber" {
  main = {
    name: "mailchimp_add_subscriber"
    input: {
      email: "subscriber@example.com"
      first_name: "John"
      last_name: "Doe"
      status: "subscribed"
    }
  }
  env = ["mailchimp_api_key", "mailchimp_server_prefix", "mailchimp_list_id"]
}
