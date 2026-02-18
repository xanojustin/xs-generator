function "fetch_crypto_price" {
  description = "Fetch current cryptocurrency prices from CoinGecko API"
  input {
    text coin_ids="bitcoin,ethereum" { description = "Comma-separated list of coin IDs (e.g., bitcoin,ethereum)" }
    text vs_currencies="usd" { description = "Comma-separated list of target currencies (e.g., usd,eur)" }
  }
  stack {
    // Build the CoinGecko API URL with query parameters
    var $url {
      value = "https://api.coingecko.com/api/v3/simple/price?ids=" ~ $input.coin_ids ~ "&vs_currencies=" ~ $input.vs_currencies
    }

    // Make the API request to CoinGecko
    api.request {
      url = $url
      method = "GET"
      headers = ["Accept: application/json"]
      timeout = 30
    } as $api_result

    // Check if the request was successful
    conditional {
      if ($api_result.response.status == 200) {
        // Parse the response
        var $prices { value = $api_result.response.result }

        // Log the fetched prices
        debug.log { value = "Successfully fetched crypto prices from CoinGecko" }
        debug.log { value = $prices }
      }
      else {
        // Log error details
        debug.log { value = "Failed to fetch prices. Status: " ~ $api_result.response.status }
        debug.log { value = $api_result.response.result }
      }
    }
  }
  response = $api_result.response.result
}
