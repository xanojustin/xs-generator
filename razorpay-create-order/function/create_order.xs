function "create_order" {
  description = "Create a payment order using Razorpay API"
  input {
    text amount filters=trim { description = "Amount to charge in smallest currency unit (e.g., 2000 for INR 20.00)" }
    text currency?="INR" filters=trim { description = "Currency code (default: INR)" }
    text receipt? filters=trim { description = "Receipt identifier for the order (optional)" }
    json notes? { description = "Key-value pairs of additional notes (optional)" }
  }

  stack {
    // Get API credentials from environment
    var $key_id { value = $env.RAZORPAY_KEY_ID }
    var $key_secret { value = $env.RAZORPAY_KEY_SECRET }

    // Validate API credentials are configured
    precondition ($key_id != null && $key_id != "") {
      error_type = "standard"
      error = "RAZORPAY_KEY_ID environment variable not configured"
    }

    precondition ($key_secret != null && $key_secret != "") {
      error_type = "standard"
      error = "RAZORPAY_KEY_SECRET environment variable not configured"
    }

    // Validate amount is provided
    precondition ($input.amount != null && $input.amount != "") {
      error_type = "inputerror"
      error = "Amount is required"
    }

    // Build the auth token (Base64 of key_id:key_secret)
    var $auth_string { value = $key_id ~ ":" ~ $key_secret }
    var $auth_token { value = $auth_string|base64_encode }

    // Build the request payload
    var $payload {
      value = {
        amount: $input.amount,
        currency: $input.currency
      }
    }

    // Add receipt if provided
    conditional {
      if ($input.receipt != null && $input.receipt != "") {
        var.update $payload {
          value = $payload|set:"receipt":$input.receipt
        }
      }
    }

    // Add notes if provided
    conditional {
      if ($input.notes != null) {
        var.update $payload {
          value = $payload|set:"notes":$input.notes
        }
      }
    }

    // Send the request to Razorpay
    api.request {
      url = "https://api.razorpay.com/v1/orders"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ $auth_token
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $order_id { value = null }
    var $status { value = null }
    var $amount_paid { value = null }
    var $amount_due { value = null }
    var $error_message { value = null }
    var $created_at { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $order_id { value = $response_body|get:"id" }
        var $status { value = $response_body|get:"status" }
        var $amount_paid { value = $response_body|get:"amount_paid" }
        var $amount_due { value = $response_body|get:"amount_due" }
        var $created_at { value = $response_body|get:"created_at" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Razorpay API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_code { value = $error_obj|get:"code" }
                var $error_desc { value = $error_obj|get:"description" }
                var $error_message {
                  value = $error_code ~ " - " ~ $error_desc
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
    order_id: $order_id,
    status: $status,
    amount_paid: $amount_paid,
    amount_due: $amount_due,
    created_at: $created_at,
    error: $error_message
  }
}
