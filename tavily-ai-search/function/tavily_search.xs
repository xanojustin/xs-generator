function "tavily_search" {
  input {
    text query
    text search_depth?="basic"
    int max_results?=5
    bool include_answer?=false
    bool include_images?=false
    bool include_raw_content?=false
  }
  stack {
    // Validate API key is configured
    precondition ($env.tavily_api_key != null && $env.tavily_api_key != "") {
      error_type = "standard"
      error = "Tavily API key is not configured. Set the tavily_api_key environment variable."
    }

    // Build the request payload
    var $payload {
      value = {
        api_key: $env.tavily_api_key,
        query: $input.query,
        search_depth: $input.search_depth,
        max_results: $input.max_results,
        include_answer: $input.include_answer,
        include_images: $input.include_images,
        include_raw_content: $input.include_raw_content
      }
    }

    // Make the API request to Tavily
    api.request {
      url = "https://api.tavily.com/search"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 60
    } as $tavily_response

    // Check for successful response
    precondition ($tavily_response.response.status >= 200 && $tavily_response.response.status < 300) {
      error_type = "standard"
      error = "Tavily API error: HTTP " ~ ($tavily_response.response.status|to_text) ~ " - " ~ ($tavily_response.response.result|json_encode)
    }

    // Extract the search results
    var $search_results {
      value = $tavily_response.response.result
    }

    // Log the search query and result count
    var $result_count {
      value = $search_results.results|count
    }
  }
  response = {
    query: $input.query,
    search_depth: $input.search_depth,
    result_count: $result_count,
    answer: $search_results.answer,
    results: $search_results.results,
    images: $search_results.images,
    response_time: $search_results.response_time
  }
}
