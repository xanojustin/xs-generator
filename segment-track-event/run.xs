run.job "Segment Track Event" {
  main = {
    name: "segment_track"
    input: {
      event: "Order Completed"
      user_id: "user_12345"
      properties: {
        order_id: "order_67890"
        total: 99.99
        currency: "USD"
        product_count: 2
      }
    }
  }
  env = ["segment_write_key"]
}