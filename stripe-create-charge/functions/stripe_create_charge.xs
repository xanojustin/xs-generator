function "stripe_create_charge" {
  description = "Create a Stripe customer and charge their payment method"
  input {
    email customer_email filters=trim|lower
    text customer_name filters=trim
    text amount filters=trim
    text currency filters=trim|lower
    text description? filters=trim
    text payment_method filters=trim
  }
  stack {
    precondition (($input.customer_email|is_empty) == false) {
      error_type = "inputerror"
      error = "Customer email is required"
    }

    precondition (($input.customer_name|is_empty) == false) {
      error_type = "inputerror"
      error = "Customer name is required"
    }

    precondition ($input.amount > 0) {
      error_type = "inputerror"
      error = "Amount must be greater than 0"
    }

    precondition (($input.payment_method|is_empty) == false) {
      error_type = "inputerror"
      error = "Payment method ID is required"
    }

    var $customer_body {
      value = {
        email: $input.customer_email,
        name: $input.customer_name
      }
    }

    api.request {
      url = "https://api.stripe.com/v1/customers"
      method = "POST"
      headers = [
        "Authorization: Bearer " ~ $env.stripe_secret_key,
        "Content-Type: application/x-www-form-urlencoded"
      ]
      params = $customer_body
    } as $customer_result

    var $customer_status {
      value = $customer_result.response.status
    }

    precondition ($customer_status == 200) {
      error_type = "standard"
      error = "Failed to create Stripe customer: " ~ $customer_result.response.body.error.message
    }

    var $customer_id {
      value = $customer_result.response.body.id
    }

    var $charge_description {
      value = ($input.description|is_empty) == false ? $input.description : "Charge for " ~ $input.customer_name
    }

    var $payment_intent_body {
      value = {
        amount: $input.amount * 100,
        currency: $input.currency,
        customer: $customer_id,
        payment_method: $input.payment_method,
        description: $charge_description,
        confirm: true,
        automatic_payment_methods: {
          enabled: true,
          allow_redirects: "never"
        }
      }
    }

    api.request {
      url = "https://api.stripe.com/v1/payment_intents"
      method = "POST"
      headers = [
        "Authorization: Bearer " ~ $env.stripe_secret_key,
        "Content-Type: application/x-www-form-urlencoded"
      ]
      params = $payment_intent_body
    } as $payment_result

    var $payment_status {
      value = $payment_result.response.status
    }

    precondition ($payment_status == 200) {
      error_type = "standard"
      error = "Failed to create payment intent: " ~ $payment_result.response.body.error.message
    }

    var $payment_intent {
      value = $payment_result.response.body
    }

    var $charge_status {
      value = $payment_intent.status == "succeeded" ? "succeeded" : $payment_intent.status
    }
  }
  response = {
    success: $charge_status == "succeeded",
    customer_id: $customer_id,
    customer_email: $input.customer_email,
    payment_intent_id: $payment_intent.id,
    amount: $input.amount,
    currency: $input.currency,
    status: $charge_status,
    description: $charge_description
  }
}
