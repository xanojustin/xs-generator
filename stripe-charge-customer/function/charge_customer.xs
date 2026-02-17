function "charge_customer" {
  input {
    text customer_id
    decimal amount
    text currency?="usd"
    text description?=""
  }

  stack {
    // Validate required inputs
    precondition ($input.customer_id != "" && $input.customer_id != null) {
      error_type = "inputerror"
      error = "customer_id is required"
    }

    precondition ($input.amount > 0) {
      error_type = "inputerror"
      error = "amount must be greater than 0"
    }

    // Build the charge payload
    var $payload {
      value = {
        customer: $input.customer_id,
        amount: ($input.amount * 100)|to_int,
        currency: $input.currency,
        description: $input.description
      }
    }

    // Create the charge via Stripe API
    api.request {
      url = "https://api.stripe.com/v1/charges"
      method = "POST"
      params = $payload
      headers = [
        "Authorization: Bearer " ~ $env.STRIPE_SECRET_KEY,
        "Content-Type: application/x-www-form-urlencoded"
      ]
      timeout = 30
    } as $stripe_result

    // Handle Stripe response
    conditional {
      if ($stripe_result.response.status == 200) {
        var $charge {
          value = {
            success: true,
            charge_id: $stripe_result.response.result.id,
            status: $stripe_result.response.result.status,
            amount: ($stripe_result.response.result.amount / 100),
            currency: $stripe_result.response.result.currency,
            customer: $stripe_result.response.result.customer,
            receipt_url: $stripe_result.response.result.receipt_url,
            created: $stripe_result.response.result.created
          }
        }

        // Log the successful charge to the table
        db.add charge_log {
          data = {
            charge_id: $stripe_result.response.result.id,
            customer_id: $input.customer_id,
            amount: $input.amount,
            currency: $input.currency,
            status: $stripe_result.response.result.status,
            created_at: now
          }
        } as $log_entry
      }
      elseif ($stripe_result.response.status == 402) {
        // Payment declined
        var $error_msg {
          value = "Payment declined: " ~ ($stripe_result.response.result.error.message ?? "Card was declined")
        }

        // Log the failed charge attempt
        db.add charge_log {
          data = {
            customer_id: $input.customer_id,
            amount: $input.amount,
            currency: $input.currency,
            status: "declined",
            error_message: $error_msg,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "PaymentDeclined"
          value = $error_msg
        }
      }
      else {
        // Other errors
        var $error_msg {
          value = "Stripe API error: " ~ ($stripe_result.response.result.error.message ?? "Unknown error")
        }

        // Log the failed charge attempt
        db.add charge_log {
          data = {
            customer_id: $input.customer_id,
            amount: $input.amount,
            currency: $input.currency,
            status: "failed",
            error_message: $error_msg,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "StripeAPIError"
          value = $error_msg
        }
      }
    }
  }

  response = $charge
}
