function "submit_metric" {
  input {
    text metric_name
    decimal value
    text type?="gauge"
    text[] tags?
    text host?=""
  }

  stack {
    // Validate required environment variables
    precondition ($env.DATADOG_API_KEY != null && $env.DATADOG_API_KEY != "") {
      error_type = "standard"
      error = "DATADOG_API_KEY environment variable is required"
    }

    precondition ($env.DATADOG_APP_KEY != null && $env.DATADOG_APP_KEY != "") {
      error_type = "standard"
      error = "DATADOG_APP_KEY environment variable is required"
    }

    // Validate metric type is valid
    precondition ($input.type == "gauge" || $input.type == "count" || $input.type == "rate") {
      error_type = "inputerror"
      error = "Invalid metric type. Must be one of: gauge, count, rate"
    }

    // Build the metric payload with conditional tags handling
    var $timestamp { value = now|to_int }
    var $tags_to_use {
      value = $input.tags ?? []
    }
    var $series_payload {
      value = {
        series: [{
          metric: $input.metric_name
          points: [[$timestamp, $input.value]]
          type: $input.type
          tags: $tags_to_use
        }]
      }
    }

    // Add host if provided
    conditional {
      if ($input.host != null && $input.host != "") {
        var $host_series {
          value = ($series_payload|get:"series")|first
        }
        var $updated_series {
          value = $host_series|set:"host":$input.host
        }
        var $updated_array {
          value = [$updated_series]
        }
        var.update $series_payload {
          value = $series_payload|set:"series":$updated_array
        }
      }
    }

    // Submit metric to Datadog
    api.request {
      url = "https://api.datadoghq.com/api/v1/series"
      method = "POST"
      params = $series_payload
      headers = [
        "Content-Type: application/json"
        "DD-API-KEY: " ~ $env.DATADOG_API_KEY
        "DD-APPLICATION-KEY: " ~ $env.DATADOG_APP_KEY
      ]
      timeout = 30
    } as $api_result

    // Check response status
    conditional {
      if ($api_result.response.status == 202) {
        var $status { value = "success" }
      }
      elseif ($api_result.response.status == 200) {
        var $status { value = "success" }
      }
      elseif ($api_result.response.status == 400) {
        throw {
          name = "BadRequest"
          value = "Invalid request format: " ~ ($api_result.response.result|json_encode)
        }
      }
      elseif ($api_result.response.status == 403) {
        throw {
          name = "AuthenticationError"
          value = "Invalid API key or Application key"
        }
      }
      elseif ($api_result.response.status == 429) {
        throw {
          name = "RateLimit"
          value = "Datadog API rate limit exceeded"
        }
      }
      else {
        throw {
          name = "APIError"
          value = "Datadog API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }

    // Build response
    var $result_data {
      value = {
        status: "success"
        metric: $input.metric_name
        value: $input.value
        type: $input.type
        timestamp: $timestamp
        tags_submitted: $tags_to_use
      }
    }
  }

  response = $result_data
}
