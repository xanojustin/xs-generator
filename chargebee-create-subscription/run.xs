run.job "Chargebee Create Subscription" {
  main = {
    name: "create_subscription"
    input: {
      plan_id: "basic-plan"
      customer_email: "customer@example.com"
      customer_first_name: "John"
      customer_last_name: "Doe"
      billing_address_line1: "123 Main Street"
      billing_address_city: "San Francisco"
      billing_address_state: "CA"
      billing_address_zip: "94105"
      billing_address_country: "US"
      trial_days: 14
    }
  }
  env = ["CHARGEBEE_API_KEY", "CHARGEBEE_SITE_NAME"]
}
