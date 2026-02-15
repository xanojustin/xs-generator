function "search_google" {
  description = "Search Google using SerpAPI and return organic search results"
  input {
    text query filters=trim { description = "Search query string" }
    text location?="United States" filters=trim { description = "Location for search results (optional)" }
    text language?="en" filters=trim { description = "Language code (optional, default: en)" }
    text num_results?="10" filters=trim { description = "Number of results to return (optional, default: 10, max: 100)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.SERPAPI_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "SERPAPI_API_KEY environment variable not configured"
    }

    // Validate query is provided
    precondition ($input.query != null && $input.query != "") {
      error_type = "inputerror"
      error = "Search query is required"
    }

    // Build the request URL with query parameters
    var $encoded_query { value = $input.query|url_encode }
    var $encoded_location { value = $input.location|url_encode }
    var $request_url {
      value = "https://serpapi.com/search?q=" ~ $encoded_query ~ "&engine=google&api_key=" ~ $api_key ~ "&location=" ~ $encoded_location ~ "&hl=" ~ $input.language ~ "&num=" ~ $input.num_results
    }

    // Send the request to SerpAPI
    api.request {
      url = $request_url
      method = "GET"
      headers = [
        "Accept: application/json"
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $search_results { value = [] }
    var $total_results { value = null }
    var $search_time { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $organic_results { value = $response_body|get:"organic_results" }
        var $search_info { value = $response_body|get:"search_information" }
        conditional {
          if ($search_info != null) {
            var $total_results { value = $search_info|get:"total_results" }
            var $search_time { value = $search_info|get:"time_taken_displayed" }
          }
        }

        // Transform organic results to clean format
        conditional {
          if ($organic_results != null && ($organic_results|count) > 0) {
            var $formatted_results { value = [] }
            foreach ($organic_results) {
              each as $result {
                var $formatted_result {
                  value = {
                    position: $result|get:"position",
                    title: $result|get:"title",
                    link: $result|get:"link",
                    snippet: $result|get:"snippet",
                    displayed_link: $result|get:"displayed_link"
                  }
                }
                var $formatted_results {
                  value = $formatted_results|push:$formatted_result
                }
              }
            }
            var $search_results { value = $formatted_results }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "SerpAPI error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_message {
                  value = $error_obj
                }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    query: $input.query,
    total_results: $total_results,
    search_time: $search_time,
    results: $search_results,
    error: $error_message
  }
}
