var:customer_id = $args.customer_id
var:amount = $args.amount
var:currency = $args.currency
var:description = $args.description

precondition ((var:customer_id|strlen) > 0) {
  error_type = "inputerror"
  error = "customer_id is required"
}

precondition (var:amount > 0) {
  error_type = "inputerror"
  error = "amount must be greater than 0"
}

precondition ((var:currency|strlen) > 0) {
  error_type = "inputerror"
  error = "currency is required (e.g., 'usd')"
}

debug.log {
  value = "Processing Stripe charge for customer: " ~ var:customer_id ~ ", amount: " ~ (var:amount|to_text) ~ " " ~ var:currency
}

var:stripe_payload = {
  customer: var:customer_id,
  amount: var:amount,
  currency: var:currency,
  description: var:description
}

api.request {
  url = "https://api.stripe.com/v1/charges"
  method = "POST"
  params = var:stripe_payload
  headers = [
    "Authorization: Bearer " ~ $env.STRIPE_SECRET_KEY,
    "Content-Type: application/x-www-form-urlencoded"
  ]
  timeout = 30
} as stripe_result

precondition ((stripe_result.response.status) >= 200 && (stripe_result.response.status) < 300) {
  error_type = "standard"
  error = "Stripe API error: " ~ (stripe_result.response.status|to_text) ~ " - " ~ (stripe_result.response.body|to_text)
}

debug.log {
  value = "Stripe charge successful. Charge ID: " ~ (stripe_result.response.result.id|to_text)
}

return = stripe_result.response.result
