function "charge_customer" {
  input {
    int amount
    text currency
    text description
    text customer_email
  }
  stack {
    // Step 1: Create a Stripe customer
    function.run "create_stripe_customer" {
      input = {
        email: $input.customer_email
        description: "Customer created via Xano Run Job"
      }
    } as $customer_result

    // Step 2: Create a payment intent to charge the customer
    api.request {
      url = "https://api.stripe.com/v1/payment_intents"
      method = "POST"
      params = {
        amount: $input.amount
        currency: $input.currency
        customer: $customer_result.customer_id
        description: $input.description
        automatic_payment_methods: { enabled: true }
      }
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: Bearer " ~ $env.stripe_secret_key
      ]
      timeout = 30
    } as $payment_result

    // Step 3: Validate the payment intent was created successfully
    precondition ($payment_result.response.status >= 200 && $payment_result.response.status < 300) {
      error_type = "standard"
      error = "Stripe API error: " ~ ($payment_result.response.status|to_text)
    }

    // Step 4: Log the successful charge
    debug.log {
      value = "Successfully created payment intent: " ~ ($payment_result.response.result.id|to_text) ~ " for customer: " ~ $input.customer_email
    }

    // Step 5: Save to database if table exists
    try_catch {
      try {
        db.add "payment" {
          data = {
            payment_intent_id: $payment_result.response.result.id
            customer_id: $customer_result.customer_id
            amount: $input.amount
            currency: $input.currency
            status: $payment_result.response.result.status
            created_at: now
          }
        }
      }
      catch {
        debug.log { value = "Note: Payment table not found, skipping database storage" }
      }
    }
  }
  response = {
    success: true
    payment_intent_id: $payment_result.response.result.id
    customer_id: $customer_result.customer_id
    amount: $input.amount
    currency: $input.currency
    status: $payment_result.response.result.status
    receipt_url: $payment_result.response.result.charges|first|get:"receipt_url":""
  }
}
