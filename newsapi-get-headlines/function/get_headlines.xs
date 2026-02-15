function "get_headlines" {
  description = "Fetch top news headlines from NewsAPI"
  input {
    text country?="us" filters=trim { description = "2-letter country code (e.g., us, gb, ca). Default: us" }
    text category? filters=trim { description = "Category: business, entertainment, general, health, science, sports, technology" }
    text query? filters=trim { description = "Search query/keywords to filter articles" }
    text page_size?="10" filters=trim { description = "Number of articles to return (max 100). Default: 10" }
    text sources? filters=trim { description = "Comma-separated list of news sources (e.g., bbc-news,cnn)" }
    text language?="en" filters=trim { description = "2-letter language code. Default: en" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.NEWSAPI_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "NEWSAPI_KEY environment variable not configured"
    }

    // Build the request URL with query parameters
    var $base_url { value = "https://newsapi.org/v2/top-headlines" }
    
    // Start with required parameters
    var $params {
      value = {
        apiKey: $api_key,
        country: $input.country,
        pageSize: $input.page_size|to_int
      }
    }

    // Add category if provided
    conditional {
      if ($input.category != null && $input.category != "") {
        var.update $params {
          value = $params|set:"category":$input.category
        }
      }
    }

    // Add query if provided
    conditional {
      if ($input.query != null && $input.query != "") {
        var.update $params {
          value = $params|set:"q":$input.query
        }
      }
    }

    // Add sources if provided (note: sources cannot be mixed with country/category)
    conditional {
      if ($input.sources != null && $input.sources != "") {
        // Remove country and category when using sources
        var $params_without_country { value = $params|unset:"country" }
        var $params_without_category { value = $params_without_country|unset:"category" }
        var.update $params {
          value = $params_without_category|set:"sources":$input.sources
        }
      }
    }

    // Add language if provided
    conditional {
      if ($input.language != null && $input.language != "") {
        var.update $params {
          value = $params|set:"language":$input.language
        }
      }
    }

    // Send the request to NewsAPI
    api.request {
      url = $base_url
      method = "GET"
      params = $params
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $articles { value = [] }
    var $total_results { value = 0 }
    var $error_message { value = null }
    var $status { value = "error" }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $status { value = $response_body|get:"status" }
        
        conditional {
          if ($status == "ok") {
            var $success { value = true }
            var $articles { value = $response_body|get:"articles" }
            var $total_results { value = $response_body|get:"totalResults" }
          }
          else {
            var $success { value = false }
            var $error_obj { value = $response_body|get:"message" }
            var $error_message {
              value = "NewsAPI error: " ~ ($error_obj|to_text)
            }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_body { value = $api_result.response.result }
        conditional {
          if ($error_body != null) {
            var $error_message {
              value = $error_body|get:"message"
            }
          }
          else {
            var $error_message {
              value = "HTTP error: " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    status: $status,
    total_results: $total_results,
    articles: $articles,
    error: $error_message
  }
}
