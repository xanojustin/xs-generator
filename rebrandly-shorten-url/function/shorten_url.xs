function "shorten_url" {
  description = "Shorten a URL using Rebrandly API"
  input {
    text destination filters=trim { description = "The long URL to shorten (required)" }
    text slashtag? filters=trim { description = "Custom short URL slug (optional, e.g., 'my-link')" }
    text title? filters=trim { description = "Title for the branded link (optional)" }
    text domain_id? filters=trim { description = "Rebrandly domain ID (optional, defaults to rebrand.ly)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.REBRANDLY_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "REBRANDLY_API_KEY environment variable not configured"
    }

    // Validate destination URL is provided
    precondition ($input.destination != null && $input.destination != "") {
      error_type = "inputerror"
      error = "Destination URL is required"
    }

    // Build the request payload
    var $payload { value = { destination: $input.destination } }

    // Add slashtag if provided
    conditional {
      if ($input.slashtag != null && $input.slashtag != "") {
        var.update $payload { value = $payload|set:"slashtag":$input.slashtag }
      }
    }

    // Add title if provided
    conditional {
      if ($input.title != null && $input.title != "") {
        var.update $payload { value = $payload|set:"title":$input.title }
      }
    }

    // Add domain ID if provided
    conditional {
      if ($input.domain_id != null && $input.domain_id != "") {
        var.update $payload { value = $payload|set:"domain":{id: $input.domain_id} }
      }
    }

    // Send the request to Rebrandly
    api.request {
      url = "https://api.rebrandly.com/v1/links"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "apikey: " ~ $api_key
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $short_url { value = null }
    var $link_id { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200 || $api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $link_id { value = $response_body|get:"id" }
        var $short_url { value = $response_body|get:"shortUrl" }
      }
      else {
        var $success { value = false }
      }
    }
  }

  response = {
    success: $success,
    short_url: $short_url,
    link_id: $link_id
  }
}