run.job "Mailchimp Add Contact" {
  main = {
    name: "add_contact"
    input: {
      email: "test@example.com"
      first_name: "Test"
      last_name: "User"
      status: "subscribed"
      tags: "xano-test,newsletter"
    }
  }
  env = ["MAILCHIMP_API_KEY", "MAILCHIMP_SERVER_PREFIX", "MAILCHIMP_AUDIENCE_ID"]
}
