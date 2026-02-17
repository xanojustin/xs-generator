function "paypal_order" {
  description = "Create a PayPal order using the PayPal REST API"
  input {
    text intent
    json purchase_units
  }
  stack {
    // Step 1: Get access token from PayPal
    var $auth_string {
      value = $env.paypal_client_id ~ ":" ~ $env.paypal_client_secret
    }

    var $encoded_auth {
      value = $auth_string|base64_encode
    }

    api.request {
      url = "https://api-m.paypal.com/v1/oauth2/token"
      method = "POST"
      params = {
        grant_type: "client_credentials"
      }
      headers = [
        "Authorization: Basic " ~ $encoded_auth,
        "Content-Type: application/x-www-form-urlencoded"
      ]
      timeout = 30
    } as $token_response

    conditional {
      if ($token_response.response.status != 200) {
        throw {
          name = "PayPalAuthError"
          value = "Failed to get PayPal access token: " ~ ($token_response.response.status|to_text) ~ " - " ~ ($token_response.response.result|json_encode)
        }
      }
    }

    var $access_token {
      value = $token_response.response.result.access_token
    }

    // Step 2: Create the order
    var $order_payload {
      value = {
        intent: $input.intent,
        purchase_units: $input.purchase_units
      }
    }

    api.request {
      url = "https://api-m.paypal.com/v2/checkout/orders"
      method = "POST"
      params = $order_payload
      headers = [
        "Authorization: Bearer " ~ $access_token,
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $order_response

    conditional {
      if ($order_response.response.status == 201) {
        var $result {
          value = $order_response.response.result
        }
      }
      else {
        throw {
          name = "PayPalOrderError"
          value = "PayPal API returned status " ~ ($order_response.response.status|to_text) ~ ": " ~ ($order_response.response.result|json_encode)
        }
      }
    }
  }
  response = $result
}
