function "create_razorpay_order" {
  description = "Create a payment order using the Razorpay API"
  input {
    int amount { description = "Amount in smallest currency unit (e.g., paise for INR). 50000 = ₹500" }
    text currency { description = "Three-letter ISO currency code (e.g., 'INR', 'USD')" }
    text receipt { description = "Your internal receipt ID for tracking" }
    json notes { description = "Key-value pairs for storing additional information" }
  }
  stack {
    var $payload {
      value = {
        amount: $input.amount,
        currency: $input.currency,
        receipt: $input.receipt,
        notes: $input.notes
      }
    }

    var $auth_string {
      value = $env.razorpay_key_id ~ ":" ~ $env.razorpay_key_secret
    }

    var $encoded_auth {
      value = $auth_string|base64_encode
    }

    api.request {
      url = "https://api.razorpay.com/v1/orders"
      method = "POST"
      params = $payload
      headers = [
        "Authorization: Basic " ~ $encoded_auth,
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $order { value = $api_result.response.result }
      }
      else {
        throw {
          name = "RazorpayAPIError"
          value = "Razorpay API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $order
}