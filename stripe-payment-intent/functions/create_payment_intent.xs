function "create_payment_intent" {
  input {
    int amount
    text currency
    text? description
  }
  stack {
    // Create payment intent via Stripe API
    api.request {
      url = "https://api.stripe.com/v1/payment_intents"
      method = "POST"
      headers = {
        "Authorization": "Bearer " + $env.stripe_secret_key
        "Content-Type": "application/x-www-form-urlencoded"
      }
      params = {
        "amount": $input.amount
        "currency": $input.currency
        "automatic_payment_methods[enabled]": "true"
        "description": $input.description ?? "Payment created by Xano run job"
      }
    } as $stripe_response
    
    // Store payment intent record in database
    db.add payment_intents {
      data = {
        stripe_id: $stripe_response.body.id
        amount: $input.amount
        currency: $input.currency
        status: $stripe_response.body.status
        client_secret: $stripe_response.body.client_secret
        description: $input.description ?? ""
        created_at: now
      }
    } as $record
  }
  response = {
    success: true
    payment_intent_id: $stripe_response.body.id
    client_secret: $stripe_response.body.client_secret
    status: $stripe_response.body.status
    amount: $input.amount
    currency: $input.currency
    db_record_id: $record.id
  }
}
