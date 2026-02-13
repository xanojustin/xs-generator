function "charge_customer" {
  description = "Charge a customer using the Stripe API"
  input {
  }
  stack {
    // Get configuration from environment variables with defaults
    var $amount {
      value = $env.stripe_amount
    }
    var $currency {
      value = $env.stripe_currency|lower
    }
    var $customer_id {
      value = $env.stripe_customer_id
    }
    var $payment_method_id {
      value = $env.stripe_payment_method_id
    }

    // Set default currency if not provided
    conditional {
      if ($currency == null) {
        var $currency {
          value = "usd"
        }
      }
    }

    // Validate required fields
    conditional {
      if ($amount == null) {
        var $result {
          value = {
            status: "error",
            message: "stripe_amount is required"
          }
        }
      }
      else {
        if ($customer_id == null) {
          var $result {
            value = {
              status: "error",
              message: "stripe_customer_id is required"
            }
          }
        }
        else {
          // Build the Stripe API URL for creating a charge
          var $stripe_url {
            value = "https://api.stripe.com/v1/charges"
          }

          // Create Authorization header with Bearer token
          var $auth_header {
            value = "Authorization: Bearer " ~ $env.stripe_secret_key
          }

          // Convert amount to cents (Stripe uses smallest currency unit)
          var $amount_cents {
            value = ($amount * 100)|round:0
          }

          // Prepare form data for the request
          var $form_data {
            value = {
              amount: $amount_cents,
              currency: $currency,
              customer: $customer_id
            }
          }

          // Add payment method if provided
          conditional {
            if ($payment_method_id != null) {
              var $form_data {
                value = {
                  amount: $amount_cents,
                  currency: $currency,
                  customer: $customer_id,
                  source: $payment_method_id
                }
              }
            }
          }

          // Make the API request to Stripe
          api.request {
            url = $stripe_url
            method = "POST"
            params = $form_data
            headers = [
              "Content-Type: application/x-www-form-urlencoded",
              $auth_header
            ]
            timeout = 30
          } as $api_result

          // Check if the request was successful
          var $http_status {
            value = ($api_result.response.status)
          }

          conditional {
            if ($http_status == 200) {
              // Charge created successfully
              var $response_data {
                value = $api_result.response.result
              }
              var $status {
                value = "success"
              }
              var $message {
                value = "Charge created successfully. Charge ID: " ~ $response_data.id
              }
              var $result {
                value = {
                  status: $status,
                  message: $message,
                  charge_id: $response_data.id,
                  amount: $response_data.amount,
                  currency: $response_data.currency,
                  status: $response_data.status,
                  receipt_url: $response_data.receipt_url,
                  stripe_response: $response_data
                }
              }
            }
            else {
              // Handle error
              var $response_data {
                value = $api_result.response.result
              }
              var $status {
                value = "error"
              }
              var $status_text {
                value = ($api_result.response.status)|to_text
              }
              var $error_message {
                value = ($response_data.error.message != null) ? $response_data.error.message : "Unknown error"
              }
              var $result {
                value = {
                  status: $status,
                  message: "Failed to create charge. Status: " ~ $status_text ~ ", Error: " ~ $error_message,
                  stripe_response: $response_data
                }
              }
            }
          }
        }
      }
    }
  }
  response = $result
}
