function "create_subscription" {
  input {
    text customer_email
    text price_id
    text? payment_method_id
    text? customer_id
  }
  
  stack {
    precondition ($input.customer_email != null && $input.customer_email != "") {
      error_type = "inputerror"
      error = "Customer email is required"
    }
    
    precondition ($input.price_id != null && $input.price_id != "") {
      error_type = "inputerror"
      error = "Price ID is required"
    }
    
    var $auth_header {
      value = "Authorization: Basic " ~ ($env.STRIPE_API_KEY|base64_encode)
    }
    
    var $stripe_customer_id { value = $input.customer_id }
    
    conditional {
      if ($stripe_customer_id == null || $stripe_customer_id == "") {
        var $customer_payload {
          value = {
            email: $input.customer_email
          }
        }
        
        conditional {
          if ($input.payment_method_id != null && $input.payment_method_id != "") {
            var.update $customer_payload {
              value = $customer_payload|set:"payment_method":$input.payment_method_id
            }
          }
        }
        
        api.request {
          url = "https://api.stripe.com/v1/customers"
          method = "POST"
          params = $customer_payload
          headers = [
            "Content-Type: application/x-www-form-urlencoded",
            $auth_header
          ]
        } as $customer_result
        
        conditional {
          if ($customer_result.response.status >= 200 && $customer_result.response.status < 300) {
            var.update $stripe_customer_id {
              value = $customer_result.response.result.id
            }
          }
          else {
            throw {
              name = "StripeError"
              value = "Failed to create customer: " ~ ($customer_result.response.result|json_encode)
            }
          }
        }
      }
    }
    
    var $subscription_payload {
      value = {
        customer: $stripe_customer_id
        items: [{ price: $input.price_id }]
      }
    }
    
    conditional {
      if ($input.payment_method_id != null && $input.payment_method_id != "") {
        var.update $subscription_payload {
          value = $subscription_payload|set:"default_payment_method":$input.payment_method_id
        }
      }
    }
    
    api.request {
      url = "https://api.stripe.com/v1/subscriptions"
      method = "POST"
      params = $subscription_payload
      headers = [
        "Content-Type: application/json",
        $auth_header
      ]
    } as $subscription_result
    
    conditional {
      if ($subscription_result.response.status >= 200 && $subscription_result.response.status < 300) {
        var $response_data {
          value = {
            success: true
            subscription: $subscription_result.response.result
          }
        }
      }
      else {
        throw {
          name = "StripeError"
          value = "Failed to create subscription: " ~ ($subscription_result.response.result|json_encode)
        }
      }
    }
  }
  
  response = $response_data
}
