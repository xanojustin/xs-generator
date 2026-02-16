function "get_crypto_price" {
  description = "Get current cryptocurrency price from Binance API"
  input {
    text symbol filters=trim { description = "Trading pair symbol (e.g., BTCUSDT, ETHUSDT, SOLUSDT)" }
  }

  stack {
    // Get API key from environment (optional for public endpoints)
    var $api_key { value = $env.BINANCE_API_KEY }

    // Validate symbol is provided
    precondition ($input.symbol != null && $input.symbol != "") {
      error_type = "inputerror"
      error = "Symbol is required (e.g., BTCUSDT)"
    }

    // Convert symbol to uppercase (Binance requires uppercase)
    var $normalized_symbol { value = $input.symbol|to_upper }

    // Build headers
    var $headers { value = ["Content-Type: application/json"] }

    // Add API key to headers if available
    conditional {
      if ($api_key != null && $api_key != "") {
        var.update $headers {
          value = $headers|push:"X-MBX-APIKEY: " ~ $api_key
        }
      }
    }

    // Send the request to Binance API (24hr ticker endpoint)
    api.request {
      url = "https://api.binance.com/api/v3/ticker/24hr"
      method = "GET"
      params = { symbol: $normalized_symbol }
      headers = $headers
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $price { value = null }
    var $price_change_24h { value = null }
    var $price_change_percent_24h { value = null }
    var $volume_24h { value = null }
    var $quote_volume_24h { value = null }
    var $high_price_24h { value = null }
    var $low_price_24h { value = null }
    var $last_update_time { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $price { value = $response_body|get:"lastPrice" }
        var $price_change_24h { value = $response_body|get:"priceChange" }
        var $price_change_percent_24h { value = $response_body|get:"priceChangePercent" }
        var $volume_24h { value = $response_body|get:"volume" }
        var $quote_volume_24h { value = $response_body|get:"quoteVolume" }
        var $high_price_24h { value = $response_body|get:"highPrice" }
        var $low_price_24h { value = $response_body|get:"lowPrice" }
        var $last_update_time { value = $response_body|get:"closeTime" }
      }
      else {
        var $success { value = false }
        var $error_body { value = $api_result.response.result }
        conditional {
          if ($error_body != null) {
            var $error_msg { value = $error_body|get:"msg" }
            var $error_code { value = $error_body|get:"code" }
            conditional {
              if ($error_msg != null) {
                var $error_message { value = $error_msg }
              }
              else {
                var $error_message {
                  value = "Binance API error: HTTP " ~ ($api_result.response.status|to_text)
                }
              }
            }
          }
          else {
            var $error_message {
              value = "Binance API error: HTTP " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    symbol: $normalized_symbol,
    price: $price,
    price_change_24h: $price_change_24h,
    price_change_percent_24h: $price_change_percent_24h,
    volume_24h: $volume_24h,
    quote_volume_24h: $quote_volume_24h,
    high_price_24h: $high_price_24h,
    low_price_24h: $low_price_24h,
    last_update_time: $last_update_time,
    error: $error_message
  }
}
