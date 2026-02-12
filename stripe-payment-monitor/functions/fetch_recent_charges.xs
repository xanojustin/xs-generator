function "fetch_recent_charges" {
  input {
    int limit?=10
    text status?="succeeded"
  }
  stack {
    // Fetch recent charges from Stripe
    api.request {
      url = "https://api.stripe.com/v1/charges"
      method = "GET"
      headers = ["Authorization: Bearer " ~ $env.stripe_secret_key]
      params = { limit: $input.limit, status: $input.status }
    } as $stripe_response

    // Check if request succeeded
    precondition ($stripe_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to fetch charges from Stripe"
    }

    // Parse the charges data
    var $charges { value = $stripe_response.response.result.data }

    // Store processed charges in database
    foreach ($charges) {
      each as $charge {
        db.add processed_charges {
          data = {
            charge_id: $charge.id
            amount: $charge.amount
            currency: $charge.currency
            customer_email: $charge.receipt_email
            description: $charge.description
            status: $charge.status
            created_at: $charge.created
            processed_at: now
          }
        }
      }
    }

    // Calculate summary statistics using filter aggregation
    var $charge_count { value = $charges|count }
    var $total_amount { value = $charges|filter:"sum":["amount"] }
  }
  response = {
    message: "Successfully processed " ~ $charge_count ~ " Stripe charges"
    total_amount_cents: $total_amount
    total_amount_usd: $total_amount / 100
    charge_count: $charge_count
    charges_stored: $charge_count
  }
}