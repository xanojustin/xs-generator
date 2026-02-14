function "exchange_token" {
  description = "Exchange a Plaid public token for an access token"
  input {
    text public_token filters=trim { description = "Plaid public token to exchange" }
  }
  stack {
    var $payload {
      value = {
        client_id: $env.plaid_client_id,
        secret: $env.plaid_secret,
        public_token: $input.public_token
      }
    }
    var $base_url { value = "" }
    conditional {
      if ($env.plaid_environment == "production") {
        var.update $base_url { value = "https://production.plaid.com" }
      }
      elseif ($env.plaid_environment == "development") {
        var.update $base_url { value = "https://development.plaid.com" }
      }
      else {
        var.update $base_url { value = "https://sandbox.plaid.com" }
      }
    }
    api.request {
      url = $base_url ~ "/item/public_token/exchange"
      method = "POST"
      params = $payload
      headers = ["Content-Type: application/json"]
    } as $api_result
    var $result { value = {} }
    conditional {
      if ($api_result.response.status == 200) {
        var $access_token {
          value = $api_result.response.result|get:"access_token"
        }
        var $item_id {
          value = $api_result.response.result|get:"item_id"
        }
        var.update $result {
          value = {
            success: true,
            access_token: $access_token,
            item_id: $item_id
          }
        }
      }
      else {
        var $error_message { value = "" }
        conditional {
          if ($api_result.response.result|has:"error_message") {
            var.update $error_message {
              value = $api_result.response.result|get:"error_message"
            }
          }
          else {
            var.update $error_message {
              value = "Plaid API error: " ~ ($api_result.response.status|to_text)
            }
          }
        }
        var.update $result {
          value = {
            success: false,
            error: $error_message,
            status_code: $api_result.response.status
          }
        }
      }
    }
  }
  response = $result
}
