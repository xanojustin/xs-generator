function "fetch_exchange_rates" {
  description = "Fetches latest currency exchange rates from Fixer.io API"
  input {
    text base_currency?="USD" filters=trim|upper
    text[] target_currencies?
  }
  stack {
    // Set default target currencies if not provided
    var $target_currencies {
      value = $input.target_currencies ?? ["EUR", "GBP", "JPY", "CAD", "AUD"]
    }

    // Validate API key is configured
    precondition ($env.FIXER_API_KEY != null && $env.FIXER_API_KEY != "") {
      error_type = "standard"
      error = "FIXER_API_KEY environment variable is required"
    }

    // Build the symbols parameter from target currencies array
    var $symbols {
      value = $target_currencies|join:","
    }

    // Build the API URL with query parameters
    var $api_url {
      value = "https://data.fixer.io/api/latest?access_key=" ~ $env.FIXER_API_KEY ~ "&base=" ~ $input.base_currency ~ "&symbols=" ~ $symbols
    }

    // Make the API request to Fixer.io
    api.request {
      url = $api_url
      method = "GET"
      timeout = 30
    } as $api_result

    // Check if the request was successful
    conditional {
      if ($api_result.response.status == 200) {
        var $fixer_data { value = $api_result.response.result }
        
        // Check if Fixer API returned success
        conditional {
          if ($fixer_data.success == true) {
            var $exchange_rates { value = $fixer_data.rates }
            var $timestamp { value = $fixer_data.timestamp }
            var $date { value = $fixer_data.date }
            
            // Build the response object
            var $result {
              value = {
                success: true,
                base: $input.base_currency,
                date: $date,
                timestamp: $timestamp,
                rates: $exchange_rates
              }
            }
          }
          else {
            // Fixer API returned an error
            var $error_info { value = $fixer_data.error }
            throw {
              name = "FixerAPIError"
              value = "Fixer API error: " ~ ($error_info.info ?? "Unknown error")
            }
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid or expired Fixer API key"
        }
      }
      elseif ($api_result.response.status == 429) {
        throw {
          name = "RateLimitError"
          value = "Fixer API rate limit exceeded"
        }
      }
      else {
        throw {
          name = "APIError"
          value = "Fixer API returned status " ~ ($api_result.response.status|to_text)
        }
      }
    }
  }
  response = $result
}
