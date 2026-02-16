run.job "Amplitude Track Event" {
  main = {
    name: "track_event"
    input: {
      event_type: "purchase"
      user_id: "user_12345"
      event_properties: {
        product: "Premium Plan"
        category: "subscription"
        price: 29.99
      }
      user_properties: {
        plan: "premium"
        signup_date: "2024-01-15"
      }
      platform: "Web"
      revenue: 29.99
      product_id: "premium_monthly"
    }
  }
  env = ["AMPLITUDE_API_KEY"]
}
