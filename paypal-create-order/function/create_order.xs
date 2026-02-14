function "create_order" {
  description = "Create a PayPal order for payment processing"
  input {
    text amount filters=trim { description = "Order amount (e.g., 10.00 for $10.00)" }
    text currency?="USD" filters=trim { description = "Currency code (default: USD)" }
    text description? filters=trim { description = "Order description (optional)" }
    text return_url filters=trim { description = "URL to redirect after successful payment" }
    text cancel_url filters=trim { description = "URL to redirect if payment is cancelled" }
    text brand_name? filters=trim { description = "Business name to display (optional)" }
  }

  stack {
    // Get environment variables
    var $client_id { value = $env.PAYPAL_CLIENT_ID }
    var $client_secret { value = $env.PAYPAL_CLIENT_SECRET }
    var $base_url { value = $env.PAYPAL_BASE_URL }

    // Validate environment variables
    precondition ($client_id != null && $client_id != "") {
      error_type = "standard"
      error = "PAYPAL_CLIENT_ID environment variable not configured"
    }

    precondition ($client_secret != null && $client_secret != "") {
      error_type = "standard"
      error = "PAYPAL_CLIENT_SECRET environment variable not configured"
    }

    precondition ($base_url != null && $base_url != "") {
      error_type = "standard"
      error = "PAYPAL_BASE_URL environment variable not configured (use https://api.sandbox.paypal.com for sandbox or https://api.paypal.com for production)"
    }

    // Validate required inputs
    precondition ($input.amount != null && $input.amount != "") {
      error_type = "inputerror"
      error = "Amount is required"
    }

    precondition ($input.return_url != null && $input.return_url != "") {
      error_type = "inputerror"
      error = "Return URL is required"
    }

    precondition ($input.cancel_url != null && $input.cancel_url != "") {
      error_type = "inputerror"
      error = "Cancel URL is required"
    }

    // Create Basic Auth credentials
    var $auth_string { value = $client_id ~ ":" ~ $client_secret }
    var $basic_auth { value = "Basic " ~ ($auth_string|base64_encode) }

    // Step 1: Get OAuth access token from PayPal
    api.request {
      url = $base_url ~ "/v1/oauth2/token"
      method = "POST"
      params = {
        grant_type: "client_credentials"
      }
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: " ~ $basic_auth
      ]
    } as $token_response

    // Check token response
    precondition ($token_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to authenticate with PayPal: HTTP " ~ ($token_response.response.status|to_text)
    }

    var $access_token { value = $token_response.response.result|get:"access_token" }
    var $token_type { value = $token_response.response.result|get:"token_type" }

    // Step 2: Build the order payload
    var $purchase_unit {
      value = {
        amount: {
          currency_code: $input.currency,
          value: $input.amount
        }
      }
    }

    // Add description to purchase unit if provided
    conditional {
      if ($input.description != null && $input.description != "") {
        var.update $purchase_unit {
          value = $purchase_unit|set:"description":$input.description
        }
      }
    }

    // Build application context
    var $application_context {
      value = {
        return_url: $input.return_url,
        cancel_url: $input.cancel_url,
        shipping_preference: "NO_SHIPPING"
      }
    }

    // Add brand name if provided
    conditional {
      if ($input.brand_name != null && $input.brand_name != "") {
        var.update $application_context {
          value = $application_context|set:"brand_name":$input.brand_name
        }
      }
    }

    // Build final order payload
    var $order_payload {
      value = {
        intent: "CAPTURE",
        purchase_units: [$purchase_unit],
        application_context: $application_context
      }
    }

    // Step 3: Create the order
    api.request {
      url = $base_url ~ "/v2/checkout/orders"
      method = "POST"
      params = $order_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: " ~ $token_type ~ " " ~ $access_token,
        "Prefer: return=representation"
      ]
    } as $order_response

    // Initialize response variables
    var $success { value = false }
    var $order_id { value = null }
    var $order_status { value = null }
    var $approve_url { value = null }
    var $error_message { value = null }

    // Parse response
    conditional {
      if ($order_response.response.status == 201 || $order_response.response.status == 200) {
        var $response_body { value = $order_response.response.result }
        var $success { value = true }
        var $order_id { value = $response_body|get:"id" }
        var $order_status { value = $response_body|get:"status" }

        // Find the approve URL from links
        var $links { value = $response_body|get:"links" }
        conditional {
          if ($links != null && ($links|count) > 0) {
            foreach ($links) {
              each as $link {
                var $rel { value = $link|get:"rel" }
                conditional {
                  if ($rel == "approve") {
                    var $approve_url { value = $link|get:"href" }
                  }
                }
              }
            }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_body { value = $order_response.response.result }
        var $error_message {
          value = "PayPal API error: HTTP " ~ ($order_response.response.status|to_text)
        }

        // Try to extract error details
        conditional {
          if ($error_body != null) {
            var $details { value = $error_body|get:"details" }
            conditional {
              if ($details != null && ($details|count) > 0) {
                var $first_error { value = $details[0] }
                var $error_description { value = $first_error|get:"description" }
                conditional {
                  if ($error_description != null) {
                    var $error_message {
                      value = $error_description
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    // Build final result
    var $result {
      value = {
        success: $success,
        order_id: $order_id,
        status: $order_status,
        approve_url: $approve_url,
        error: $error_message
      }
    }
  }

  response = $result
}