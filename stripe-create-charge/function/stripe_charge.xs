function "stripe_charge" {
  description = "Create a charge using the Stripe API"
  input {
    int amount { description = "Amount in cents (e.g., 2000 for $20.00)" }
    text currency { description = "Three-letter ISO currency code (e.g., 'usd')" }
    text source { description = "Payment source token (e.g., 'tok_visa' for testing)" }
    text description { description = "Description of the charge" }
  }
  stack {
    var $payload {
      value = {
        amount: $input.amount,
        currency: $input.currency,
        source: $input.source,
        description: $input.description
      }
    }

    api.request {
      url = "https://api.stripe.com/v1/charges"
      method = "POST"
      params = $payload
      headers = [
        "Authorization: Bearer " ~ $env.stripe_secret_key,
        "Content-Type: application/x-www-form-urlencoded"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $charge { value = $api_result.response.result }
      }
      else {
        throw {
          name = "StripeAPIError"
          value = "Stripe API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $charge
}
