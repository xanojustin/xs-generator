run.job "Segment Track Event" {
  main = {
    name: "segment_track_event"
    input: {
      user_id: "user_12345"
      event: "Product Purchased"
      properties: {
        product_id: "prod_789",
        product_name: "Premium Subscription",
        price: 99.99,
        currency: "USD",
        quantity: 1
      }
      context: {
        ip: "203.0.113.1",
        userAgent: "Mozilla/5.0"
      }
    }
  }
  env = ["segment_write_key"]
}
