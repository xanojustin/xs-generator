function "charge_pending_invoices" {
  description = "Find pending invoices and charge customers via Stripe"
  input {
  }
  stack {
    // Get pending invoices that are due
    db.query "invoice" {
      where = $db.invoice.status == "pending" && $db.invoice.due_date <= now
    } as $pending_invoices

    var $results { value = [] }

    foreach ($pending_invoices) {
      each as $invoice {
        // Get customer with Stripe payment method
        db.get "customer" {
          field_name = "id"
          field_value = $invoice.customer_id
        } as $customer

        conditional {
          if ($customer.stripe_customer_id != null && $customer.stripe_payment_method_id != null) {
            // Create payment intent with Stripe
            api.request {
              url = "https://api.stripe.com/v1/payment_intents"
              method = "POST"
              headers = [
                "Authorization: Bearer " ~ $env.STRIPE_SECRET_KEY,
                "Content-Type: application/x-www-form-urlencoded"
              ]
              params = {
                amount: $invoice.amount_cents,
                currency: "usd",
                customer: $customer.stripe_customer_id,
                payment_method: $customer.stripe_payment_method_id,
                off_session: "true",
                confirm: "true",
                description: "Invoice #" ~ $invoice.id
              }
            } as $stripe_response

            conditional {
              if ($stripe_response.response.status == 200) {
                var $payment_intent { value = $stripe_response.response.result }
                
                conditional {
                  if ($payment_intent.status == "succeeded") {
                    // Update invoice as paid
                    db.edit "invoice" {
                      field_name = "id"
                      field_value = $invoice.id
                      data = {
                        status: "paid",
                        paid_at: now,
                        stripe_payment_intent_id: $payment_intent.id
                      }
                    }
                    var $results { value = $results|push:{ invoice_id: $invoice.id, status: "paid", payment_intent_id: $payment_intent.id } }
                  }
                  else {
                    var $results { value = $results|push:{ invoice_id: $invoice.id, status: $payment_intent.status } }
                  }
                }
              }
              else {
                var $results { value = $results|push:{ invoice_id: $invoice.id, status: "error", error: $stripe_response.response.result|get:"error"|get:"message" } }
              }
            }
          }
          else {
            var $results { value = $results|push:{ invoice_id: $invoice.id, status: "skipped", reason: "no_stripe_customer" } }
          }
        }
      }
    }
  }
  response = $results
}
