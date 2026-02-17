run.job "Razorpay Create Order" {
  main = {
    name: "create_razorpay_order"
    input: {
      amount: 50000
      currency: "INR"
      receipt: "order_rcptid_11"
      notes: {
        customer_name: "John Doe"
        customer_email: "john@example.com"
      }
    }
  }
  env = ["razorpay_key_id", "razorpay_key_secret"]
}