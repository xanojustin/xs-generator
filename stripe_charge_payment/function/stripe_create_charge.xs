function "stripe_create_charge" {
  description = "Creates a Stripe charge for a customer"
  input {
    text customer_id { description = "Stripe customer ID (e.g., cus_1234567890)" }
    int amount { description = "Amount in smallest currency unit (e.g., cents for USD)" }
    text currency { description = "3-letter ISO currency code (e.g., usd)" }
    text description { description = "Optional charge description" }
  }
  stack {
    var $stripe_payload {
      value = {
        customer: $input.customer_id,
        amount: $input.amount,
        currency: $input.currency,
        description: $input.description
      }
    }

    api.request {
      url = "https://api.stripe.com/v1/charges"
      method = "POST"
      params = $stripe_payload
      headers = [
        "Authorization: Bearer " ~ $env.STRIPE_SECRET_KEY,
        "Content-Type: application/x-www-form-urlencoded"
      ]
      timeout = 30
    } as $stripe_result

    precondition (($stripe_result.response.status) >= 200 && ($stripe_result.response.status) < 300) {
      error_type = "standard"
      error = "Stripe API error: " ~ ($stripe_result.response.status|to_text) ~ " - " ~ ($stripe_result.response.body|to_text)
    }

    var $charge_result {
      value = $stripe_result.response.result
    }
  }
  response = $charge_result
}
