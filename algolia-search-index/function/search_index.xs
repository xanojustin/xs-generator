function "search_index" {
  description = "Search an Algolia index using the Search API"
  input {
    text query filters=trim { description = "Search query string" }
    text index_name filters=trim { description = "Name of the Algolia index to search" }
    int hits_per_page?=10 { description = "Number of results per page (default: 10)" }
    int page?=0 { description = "Page number for pagination (default: 0)" }
    text attributes_to_retrieve? filters=trim { description = "Comma-separated list of attributes to retrieve (optional)" }
    text filters? filters=trim { description = "Algolia filters query (optional, e.g., category:electronics)" }
  }

  stack {
    // Get environment variables
    var $app_id { value = $env.ALGOLIA_APP_ID }
    var $api_key { value = $env.ALGOLIA_API_KEY }
    var $search_key { value = $env.ALGOLIA_SEARCH_KEY }

    // Validate required environment variables
    precondition ($app_id != null && $app_id != "") {
      error_type = "standard"
      error = "ALGOLIA_APP_ID environment variable not configured"
    }

    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "ALGOLIA_API_KEY environment variable not configured"
    }

    // Validate required inputs
    precondition ($input.query != null && $input.query != "") {
      error_type = "inputerror"
      error = "Search query is required"
    }

    precondition ($input.index_name != null && $input.index_name != "") {
      error_type = "inputerror"
      error = "Index name is required"
    }

    // Build the search parameters string
    var $params {
      value = "query=" ~ ($input.query|url_encode) ~ "&hitsPerPage=" ~ ($input.hits_per_page|to_text) ~ "&page=" ~ ($input.page|to_text)
    }

    // Add optional filters if provided
    conditional {
      if ($input.filters != null && $input.filters != "") {
        var $params {
          value = $params ~ "&filters=" ~ ($input.filters|url_encode)
        }
      }
    }

    // Add optional attributes_to_retrieve if provided
    conditional {
      if ($input.attributes_to_retrieve != null && $input.attributes_to_retrieve != "") {
        var $params {
          value = $params ~ "&attributesToRetrieve=" ~ ($input.attributes_to_retrieve|url_encode)
        }
      }
    }

    // Build the request payload
    var $payload {
      value = { params: $params }
    }

    // Determine which key to use for search (prefer search key if available)
    var $auth_key { value = $api_key }
    conditional {
      if ($search_key != null && $search_key != "") {
        var $auth_key { value = $search_key }
      }
    }

    // Build the search URL
    var $search_url {
      value = "https://" ~ $app_id ~ "-dsn.algolia.net/1/indexes/" ~ $input.index_name ~ "/query"
    }

    // Send the search request to Algolia
    api.request {
      url = $search_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "X-Algolia-Application-Id: " ~ $app_id,
        "X-Algolia-API-Key: " ~ $auth_key
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $hits { value = [] }
    var $total_hits { value = 0 }
    var $page { value = 0 }
    var $nb_pages { value = 0 }
    var $processing_time_ms { value = 0 }
    var $query { value = $input.query }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $hits { value = $response_body|get:"hits" }
        var $total_hits { value = $response_body|get:"nbHits" }
        var $page { value = $response_body|get:"page" }
        var $nb_pages { value = $response_body|get:"nbPages" }
        var $processing_time_ms { value = $response_body|get:"processingTimeMS" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Algolia API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"message" }
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
    query: $query,
    hits: $hits,
    total_hits: $total_hits,
    page: $page,
    total_pages: $nb_pages,
    processing_time_ms: $processing_time_ms,
    error: $error_message
  }
}
