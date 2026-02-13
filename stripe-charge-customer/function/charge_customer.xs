function "charge_customer" {
  description = "Charge a customer using Stripe API"
  input {
    text amount filters=trim { description = "Amount to charge in cents (e.g., 2000 for $20.00)" }
    text currency?="usd" filters=trim { description = "Currency code (default: usd)" }
    text payment_method filters=trim { description = "Stripe payment method ID (e.g., pm_1234567890)" }
    text description? filters=trim { description = "Description of the charge (optional)" }
    text customer_id? filters=trim { description = "Stripe customer ID (optional, e.g., cus_1234567890)" }
    text receipt_email? filters=trim { description = "Email to send receipt to (optional)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.STRIPE_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "STRIPE_API_KEY environment variable not configured"
    }

    // Validate amount is provided
    precondition ($input.amount != null && $input.amount != "") {
      error_type = "inputerror"
      error = "Amount is required"
    }

    // Validate payment method is provided
    precondition ($input.payment_method != null && $input.payment_method != "") {
      error_type = "inputerror"
      error = "Payment method is required"
    }

    // Build the request payload
    var $payload {
      value = {
        amount: $input.amount,
        currency: $input.currency,
        payment_method: $input.payment_method,
        confirm: true,
        automatic_payment_methods: { enabled: true, allow_redirects: "never" }
      }
    }

    // Add description if provided
    conditional {
      if ($input.description != null && $input.description != "") {
        var.update $payload {
          value = $payload|set:"description":$input.description
        }
      }
    }

    // Add customer ID if provided
    conditional {
      if ($input.customer_id != null && $input.customer_id != "") {
        var.update $payload {
          value = $payload|set:"customer":$input.customer_id
        }
      }
    }

    // Add receipt email if provided
    conditional {
      if ($input.receipt_email != null && $input.receipt_email != "") {
        var.update $payload {
          value = $payload|set:"receipt_email":$input.receipt_email
        }
      }
    }

    // Send the request to Stripe
    api.request {
      url = "https://api.stripe.com/v1/payment_intents"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: Bearer " ~ $api_key
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $payment_intent_id { value = null }
    var $status { value = null }
    var $error_message { value = null }
    var $client_secret { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $payment_intent_id { value = $response_body|get:"id" }
        var $status { value = $response_body|get:"status" }
        var $client_secret { value = $response_body|get:"client_secret" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Stripe API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_message {
                  value = $error_obj|get:"message"
                }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    payment_intent_id: $payment_intent_id,
    status: $status,
    client_secret: $client_secret,
    error: $error_message
  }
}
