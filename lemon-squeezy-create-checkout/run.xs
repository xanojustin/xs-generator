run.job "Lemon Squeezy Create Checkout" {
  main = {
    name: "lemon_squeezy_create_checkout"
    input: {
      store_id: "your-store-id"
      variant_id: "your-variant-id"
      email: "customer@example.com"
      name: "John Doe"
      billing_address_country: "US"
      billing_address_zip: "12345"
    }
  }
  env = ["lemon_squeezy_api_key"]
}
