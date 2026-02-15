run.job "LemonSqueezy Create Checkout" {
  main = {
    name: "create_checkout"
    input: {
      store_id: "your-store-id-here"
      variant_id: "your-variant-id-here"
      customer_email: "customer@example.com"
      customer_name: "John Doe"
      redirect_url: "https://your-app.com/thank-you"
    }
  }
  env = ["LEMONSQUEEZY_API_KEY"]
}
