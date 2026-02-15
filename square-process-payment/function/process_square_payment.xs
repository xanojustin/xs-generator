function "process_square_payment" {
  description = "Process a payment using the Square Payments API"
  input {
    int amount { description = "Payment amount in cents (e.g., 1000 = $10.00)" }
    text currency?="USD" { description = "Currency code (default: USD)" }
    text source_id { description = "Square payment source ID (card nonce or token)" }
    text idempotency_key?="" { description = "Unique idempotency key (auto-generated if empty)" }
    text note?="" { description = "Optional note for the payment" }
  }
  stack {
    // Generate idempotency key if not provided
    var $idempotency { value = $input.idempotency_key }
    conditional {
      if ($input.idempotency_key == "") {
        var.update $idempotency { value = "xano-" ~ (|uuid) }
      }
    }

    // Determine Square API base URL based on environment
    var $base_url { value = "https://connect.squareupsandbox.com" }
    conditional {
      if ($env.SQUARE_ENVIRONMENT == "production") {
        var.update $base_url { value = "https://connect.squareup.com" }
      }
    }

    // Build the payment request payload
    var $payload {
      value = {
        idempotency_key: $idempotency,
        amount_money: {
          amount: $input.amount,
          currency: $input.currency
        },
        source_id: $input.source_id
      }
    }

    // Add note if provided
    conditional {
      if ($input.note != "") {
        var.update $payload {
          value = $payload|set:"note":$input.note
        }
      }
    }

    // Make the Square API request
    api.request {
      url = $base_url ~ "/v2/payments"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.SQUARE_ACCESS_TOKEN,
        "Square-Version: 2024-01-01"
      ]
      timeout = 30
    } as $api_result

    // Handle the response
    var $payment { value = null }
    var $status { value = "error" }
    var $message { value = "" }

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var.update $payment { value = $api_result.response.result }
        var.update $status { value = "success" }
        var.update $message { value = "Payment processed successfully" }
      }
      elseif ($api_result.response.status == 401) {
        var.update $message { value = "Authentication failed - check your Square access token" }
      }
      elseif ($api_result.response.status == 400) {
        var.update $message { value = "Bad request - " ~ ($api_result.response.result|json_encode) }
      }
      else {
        var.update $message { value = "Square API error: " ~ ($api_result.response.status|to_text) }
      }
    }

    // Determine environment for response
    var $environment { value = "sandbox" }
    conditional {
      if ($env.SQUARE_ENVIRONMENT == "production") {
        var.update $environment { value = "production" }
      }
    }

    // Build the final result
    var $result {
      value = {
        status: $status,
        message: $message,
        payment: $payment,
        idempotency_key: $idempotency,
        request_details: {
          amount: $input.amount,
          currency: $input.currency,
          environment: $environment
        }
      }
    }
  }
  response = $result
}