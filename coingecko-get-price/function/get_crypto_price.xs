function "get_crypto_price" {
  input {
    text coin_id
    text currency
  }
  stack {
    precondition ($input.coin_id != null && $input.coin_id != "") {
      error_type = "inputerror"
      error = "Coin ID is required (e.g., bitcoin, ethereum)"
    }

    precondition ($input.currency != null && $input.currency != "") {
      error_type = "inputerror"
      error = "Currency is required (e.g., usd, eur)"
    }

    var $api_url {
      value = "https://api.coingecko.com/api/v3/simple/price?ids=" ~ ($input.coin_id|to_lower) ~ "&vs_currencies=" ~ ($input.currency|to_lower) ~ "&include_24hr_change=true&include_market_cap=true&include_24hr_vol=true"
    }

    api.request {
      url = $api_url
      method = "GET"
      headers = ["Accept: application/json"]
    } as $api_result

    precondition ($api_result.response.status == 200) {
      error_type = "standard"
      error = "CoinGecko API request failed with status: " ~ ($api_result.response.status|to_text)
    }

    var $price_data {
      value = $api_result.response.result|get:($input.coin_id|to_lower)
    }

    precondition ($price_data != null) {
      error_type = "notfound"
      error = "Cryptocurrency not found: " ~ $input.coin_id
    }

    var $price {
      value = $price_data|get:($input.currency|to_lower)
    }

    var $market_cap {
      value = $price_data|get:($input.currency|to_lower) ~ "_market_cap"
    }

    var $volume_24h {
      value = $price_data|get:($input.currency|to_lower) ~ "_24h_vol"
    }

    var $change_24h {
      value = $price_data|get:($input.currency|to_lower) ~ "_24h_change"
    }

    var $crypto_data {
      value = {
        coin_id: $input.coin_id|to_lower,
        currency: $input.currency|to_lower,
        price: $price,
        market_cap: $market_cap,
        volume_24h: $volume_24h,
        change_24h_percent: $change_24h,
        fetched_at: now|format_timestamp:"Y-m-d H:i:s":"UTC"
      }
    }
  }
  response = $crypto_data
}
