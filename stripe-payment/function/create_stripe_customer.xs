function "create_stripe_customer" {
  input {
    text email
    text description?=""
  }
  stack {
    // Build the request parameters
    var $params {
      value = {
        email: $input.email
      }
    }

    // Add description if provided
    conditional {
      if ($input.description != "") {
        var.update $params {
          value = $params|set:"description":$input.description
        }
      }
    }

    // Call Stripe API to create customer
    api.request {
      url = "https://api.stripe.com/v1/customers"
      method = "POST"
      params = $params
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: Bearer " ~ $env.stripe_secret_key
      ]
      timeout = 30
    } as $stripe_response

    // Validate response
    precondition ($stripe_response.response.status >= 200 && $stripe_response.response.status < 300) {
      error_type = "standard"
      error = "Failed to create Stripe customer: " ~ ($stripe_response.response.status|to_text)
    }

    // Log success
    debug.log {
      value = "Created Stripe customer: " ~ ($stripe_response.response.result.id|to_text)
    }
  }
  response = {
    customer_id: $stripe_response.response.result.id
    email: $stripe_response.response.result.email
    created: $stripe_response.response.result.created
  }
}
