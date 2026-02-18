function "charge_customer" {
  description = "Charge a customer using Stripe API"
  input {
    int amount filters=min:1 { description = "Amount in cents (e.g., 2000 for $20.00)" }
    text currency?="usd" filters=lower { description = "Currency code (e.g., usd, eur, gbp)" }
    text customer_email filters=trim|lower { description = "Customer email address" }
    text description?="Payment" filters=trim { description = "Description of the charge" }
  }
  stack {
    var $payload {
      value = {
        amount: $input.amount,
        currency: $input.currency,
        "payment_method_types[]": "card",
        receipt_email: $input.customer_email,
        description: $input.description
      }
    }

    api.request {
      url = "https://api.stripe.com/v1/payment_intents"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: Bearer " ~ $env.STRIPE_API_KEY
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $payment_intent { value = $api_result.response.result }

        db.add charge_log {
          data = {
            stripe_payment_intent_id: $payment_intent.id,
            amount: $input.amount,
            currency: $input.currency,
            customer_email: $input.customer_email,
            description: $input.description,
            status: $payment_intent.status,
            created_at: now
          }
        } as $log_entry

        var $result {
          value = {
            success: true,
            payment_intent_id: $payment_intent.id,
            status: $payment_intent.status,
            amount: $input.amount,
            currency: $input.currency,
            log_id: $log_entry.id
          }
        }
      }
      else {
        var $error_message {
          value = "Stripe API error: " ~ ($api_result.response.result.error.message|to_text)
        }

        db.add charge_log {
          data = {
            amount: $input.amount,
            currency: $input.currency,
            customer_email: $input.customer_email,
            description: $input.description,
            status: "failed",
            error_message: $error_message,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "StripeError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}
