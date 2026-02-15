function "set_redis_key" {
  input {
    text key
    text value
    int ttl?
  }
  stack {
    // Validate required inputs
    precondition ($input.key != null && $input.key != "") {
      error_type = "inputerror"
      error = "Key is required"
    }

    precondition ($input.value != null) {
      error_type = "inputerror"
      error = "Value is required"
    }

    // Validate environment variables
    precondition ($env.upstash_redis_rest_url != null && $env.upstash_redis_rest_url != "") {
      error_type = "standard"
      error = "UPSTASH_REDIS_REST_URL environment variable is required"
    }

    precondition ($env.upstash_redis_rest_token != null && $env.upstash_redis_rest_token != "") {
      error_type = "standard"
      error = "UPSTASH_REDIS_REST_TOKEN environment variable is required"
    }

    // Build the Upstash Redis REST API URL for SET command
    // Upstash REST API format: /set/<key>/<value>
    var $encoded_key { value = $input.key|url_encode }
    var $encoded_value { value = $input.value|url_encode }
    var $set_url { value = $env.upstash_redis_rest_url ~ "/set/" ~ $encoded_key ~ "/" ~ $encoded_value }

    // Add TTL (expiration) if provided
    conditional {
      if ($input.ttl != null && $input.ttl > 0) {
        var $set_url { value = $set_url ~ "?EX=" ~ ($input.ttl|to_text) }
      }
    }

    // Make request to Upstash Redis REST API
    api.request {
      url = $set_url
      method = "GET"
      headers = [
        "Authorization: Bearer " ~ $env.upstash_redis_rest_token
      ]
      timeout = 30
    } as $redis_result

    // Check for success
    conditional {
      if ($redis_result.response.status >= 200 && $redis_result.response.status < 300) {
        // Upstash returns "OK" on successful SET
        var $success { value = true }
        var $redis_response { value = $redis_result.response.result }
      }
      else {
        var $success { value = false }
        var $error_message { value = "Upstash Redis API error: HTTP " ~ ($redis_result.response.status|to_text) }
      }
    }

    // Build response
    var $api_result {
      value = {
        success: $success,
        key: $input.key,
        value: $input.value,
        ttl: $input.ttl,
        redis_response: $redis_response ?? null
      }
    }

    conditional {
      if ($success == false) {
        var.update $api_result { value = $api_result|set:"error":$error_message }
      }
    }
  }
  response = $api_result
}
