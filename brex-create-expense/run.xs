run.job "Brex Create Expense" {
  main = {
    name: "brex_create_expense"
    input: {
      merchant_name: "AWS Services"
      amount: 149.99
      currency: "USD"
      category: "software"
      memo: "Monthly EC2 and RDS hosting costs"
      purchase_date: "now"
    }
  }
  env = ["brex_api_token"]
}
