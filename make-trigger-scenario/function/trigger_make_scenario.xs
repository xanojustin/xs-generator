function "trigger_make_scenario" {
  description = "Trigger a Make.com scenario via webhook with custom payload data"
  input {
    text scenario_name
    json payload
  }
  stack {
    // Validate webhook URL is configured
    precondition ($env.make_webhook_url != null) {
      error_type = "standard"
      error = "make_webhook_url environment variable is not configured"
    }

    // Validate scenario name
    precondition ($input.scenario_name != null) {
      error_type = "inputerror"
      error = "scenario_name is required"
    }

    // Build the webhook payload with metadata
    var $webhook_payload {
      value = {
        scenario_name: $input.scenario_name,
        triggered_at: now,
        source: "xano-run-job",
        data: $input.payload
      }
    }

    // Send webhook request to Make
    api.request {
      url = $env.make_webhook_url
      method = "POST"
      params = $webhook_payload
      headers = [
        "Content-Type: application/json",
        "User-Agent: Xano-Run-Job/1.0"
      ]
      timeout = 30
    } as $api_result

    // Check response status
    conditional {
      if ($api_result.response.status == 200) {
        var $status { value = "success" }
        var $message { value = "Scenario triggered successfully" }
      }
      elseif ($api_result.response.status == 429) {
        var $status { value = "rate_limited" }
        var $message { value = "Make API rate limit exceeded" }
      }
      else {
        var $status { value = "error" }
        var $message { value = "Make API error" }
      }
    }

    // Build response
    var $result {
      value = {
        status: $status,
        message: $message,
        scenario_name: $input.scenario_name,
        http_status: $api_result.response.status
      }
    }
  }
  response = $result
}
