function "brave_web_search" {
  input {
    text query filters=trim
    int count?=10
    text search_lang?="en"
    text country?="US"
  }
  
  stack {
    // Validate required inputs
    precondition ($input.query != null && $input.query != "") {
      error_type = "inputerror"
      error = "Search query is required"
    }
    
    // Validate count is within acceptable range (1-20)
    precondition ($input.count >= 1 && $input.count <= 20) {
      error_type = "inputerror"
      error = "Count must be between 1 and 20"
    }
    
    // Build the API URL with query parameters
    var $api_url {
      value = "https://api.search.brave.com/res/v1/web/search?q=" ~ ($input.query|url_encode) ~ "&count=" ~ ($input.count|to_text) ~ "&search_lang=" ~ $input.search_lang ~ "&country=" ~ $input.country
    }
    
    // Make the API request to Brave Search
    api.request {
      url = $api_url
      method = "GET"
      headers = [
        "Content-Type: application/json",
        "Accept: application/json",
        "X-Subscription-Token: " ~ $env.BRAVE_API_KEY
      ]
      timeout = 30
    } as $search_response
    
    // Handle different response statuses
    conditional {
      if ($search_response.response.status == 200) {
        // Extract search results from response
        var $search_data { value = $search_response.response.result }
        
        // Extract web results - handle potential missing fields safely
        var $web_results { value = [] }
        conditional {
          if ($search_data|get:"web":null != null) {
            var $web_section { value = $search_data|get:"web":{} }
            var $results_array { value = $web_section|get:"results":[] }
            var.update $web_results { value = $results_array }
          }
        }
        
        // Process results into a clean format
        var $formatted_results { value = [] }
        foreach ($web_results) {
          each as $item {
            var $item_title { value = $item|get:"title":"" }
            var $item_url { value = $item|get:"url":"" }
            var $item_desc { value = $item|get:"description":"" }
            var $item_age { value = $item|get:"age":"" }
            var $item_profile { value = $item|get:"profile":{} }
            var $item_source { value = $item_profile|get:"name":"" }
            
            var $formatted_item {
              value = {
                title: $item_title,
                url: $item_url,
                description: $item_desc,
                published_date: $item_age,
                source: $item_source
              }
            }
            
            var $current_formatted { value = $formatted_results }
            var $new_formatted { value = $current_formatted|push:$formatted_item }
            var.update $formatted_results { value = $new_formatted }
          }
        }
        
        // Extract query info safely
        var $query_info { value = { original: $input.query, altered: null, show_strict_warning: false } }
        conditional {
          if ($search_data|get:"query":null != null) {
            var $query_section { value = $search_data|get:"query":{} }
            var $original_query { value = $query_section|get:"original":$input.query }
            var $altered_query { value = $query_section|get:"altered":null }
            var $strict_warning { value = $query_section|get:"show_strict_warning":false }
            
            var.update $query_info {
              value = {
                original: $original_query,
                altered: $altered_query,
                show_strict_warning: $strict_warning
              }
            }
          }
        }
        
        // Format the final output
        var $result {
          value = {
            success: true,
            query: $query_info,
            results_count: ($web_results|count),
            results: $formatted_results,
            timestamp: now
          }
        }
      }
      elseif ($search_response.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid Brave API key. Please check your BRAVE_API_KEY environment variable."
        }
      }
      elseif ($search_response.response.status == 429) {
        throw {
          name = "RateLimitError"
          value = "Rate limit exceeded. Brave Search API has quota limits. Please wait and try again."
        }
      }
      elseif ($search_response.response.status == 422) {
        throw {
          name = "ValidationError"
          value = "Invalid search parameters: " ~ ($search_response.response.result|json_encode)
        }
      }
      else {
        throw {
          name = "APIError"
          value = "Brave Search API returned status " ~ ($search_response.response.status|to_text) ~ ": " ~ ($search_response.response.result|json_encode)
        }
      }
    }
  }
  
  response = $result
}
