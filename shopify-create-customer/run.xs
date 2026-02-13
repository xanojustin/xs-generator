run.job "Shopify Create Customer" {
  main = {
    name: "create_customer"
    input: {
      email: "customer@example.com"
      first_name: "John"
      last_name: "Doe"
      phone: "+1234567890"
      verified_email: true
      send_email_invite: false
    }
  }
  env = ["shopify_shop_domain", "shopify_access_token"]
}
