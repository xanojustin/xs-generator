run.job "Razorpay Create Order" {
  main = {
    name: "create_order"
    input: {
      amount: "2000"
      currency: "INR"
      receipt: "order_receipt_001"
      notes: {
        customer_name: "John Doe"
        customer_email: "john@example.com"
        order_type: "test_order"
      }
    }
  }
  env = ["RAZORPAY_KEY_ID", "RAZORPAY_KEY_SECRET"]
}
