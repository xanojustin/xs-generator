function "create_payment" {
  input {
    text source_id
    decimal amount
    text currency?="USD"
    text note?=""
    text reference_id?=""
  }

  stack {
    // Validate required inputs
    precondition ($input.source_id != "" && $input.source_id != null) {
      error_type = "inputerror"
      error = "source_id is required"
    }

    precondition ($input.amount > 0) {
      error_type = "inputerror"
      error = "amount must be greater than 0"
    }

    // Determine base URL based on environment
    var $base_url {
      value = "https://connect.squareupsandbox.com"
    }
    
    conditional {
      if ($env.SQUARE_ENVIRONMENT == "production") {
        var $base_url {
          value = "https://connect.squareup.com"
        }
      }
    }

    // Generate idempotency key (required by Square)
    var $idempotency_key {
      value = "sq-" ~ (now|to_int|to_text)
    }

    // Build the payment payload
    var $payload {
      value = {
        idempotency_key: $idempotency_key,
        source_id: $input.source_id,
        amount_money: {
          amount: ($input.amount * 100)|to_int,
          currency: $input.currency
        },
        note: $input.note,
        reference_id: $input.reference_id
      }
    }

    // Create the payment via Square API
    api.request {
      url = $base_url ~ "/v2/payments"
      method = "POST"
      params = $payload
      headers = [
        "Authorization: Bearer " ~ $env.SQUARE_ACCESS_TOKEN,
        "Content-Type: application/json",
        "Square-Version: 2024-01-18"
      ]
      timeout = 30
    } as $square_result

    // Handle Square response
    conditional {
      if ($square_result.response.status == 200) {
        var $payment {
          value = {
            success: true,
            payment_id: $square_result.response.result.payment.id,
            status: $square_result.response.result.payment.status,
            amount: ($square_result.response.result.payment.amount_money.amount / 100),
            currency: $square_result.response.result.payment.amount_money.currency,
            receipt_url: $square_result.response.result.payment.receipt_url,
            created_at: $square_result.response.result.payment.created_at
          }
        }

        // Log the successful payment to the table
        db.add payment_log {
          data = {
            payment_id: $square_result.response.result.payment.id,
            reference_id: $input.reference_id,
            amount: $input.amount,
            currency: $input.currency,
            status: $square_result.response.result.payment.status,
            receipt_url: $square_result.response.result.payment.receipt_url,
            created_at: now
          }
        } as $log_entry
      }
      elseif ($square_result.response.status == 400) {
        // Bad request - invalid card, insufficient funds, etc.
        var $error_msg {
          value = "Payment failed: " ~ ($square_result.response.result.errors[0].detail ?? "Invalid request")
        }

        // Log the failed payment attempt
        db.add payment_log {
          data = {
            reference_id: $input.reference_id,
            amount: $input.amount,
            currency: $input.currency,
            status: "failed",
            error_message: $error_msg,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "PaymentFailed"
          value = $error_msg
        }
      }
      elseif ($square_result.response.status == 401) {
        // Authentication error
        var $error_msg {
          value = "Authentication failed: Invalid Square access token"
        }

        db.add payment_log {
          data = {
            reference_id: $input.reference_id,
            amount: $input.amount,
            currency: $input.currency,
            status: "auth_failed",
            error_message: $error_msg,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "AuthenticationError"
          value = $error_msg
        }
      }
      else {
        // Other errors
        var $error_msg {
          value = "Square API error: " ~ ($square_result.response.result.errors[0].detail ?? "Unknown error")
        }

        // Log the failed payment attempt
        db.add payment_log {
          data = {
            reference_id: $input.reference_id,
            amount: $input.amount,
            currency: $input.currency,
            status: "error",
            error_message: $error_msg,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "SquareAPIError"
          value = $error_msg
        }
      }
    }
  }

  response = $payment
}
