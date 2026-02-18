function "trigger_zap" {
  input {
    text webhook_url
    json data?
  }
  stack {
    // Validate webhook URL
    precondition ($input.webhook_url != null && $input.webhook_url != "") {
      error_type = "inputerror"
      error = "webhook_url is required"
    }

    // Prepare payload - use input data or empty object
    var $payload {
      value = ($input.data != null) ? $input.data : {}
    }

    // Add metadata to the payload
    var $payload_with_meta {
      value = $payload|set:"_triggered_at":now|set:"_source":"xano_run_job"
    }

    // Make the POST request to Zapier webhook
    api.request {
      url = $input.webhook_url
      method = "POST"
      params = $payload_with_meta
      headers = ["Content-Type: application/json"]
      timeout = 30
    } as $zapier_response

    // Check for successful response
    conditional {
      if ($zapier_response.response.status >= 200 && $zapier_response.response.status < 300) {
        var $result {
          value = {
            success: true
            status: $zapier_response.response.status
            message: "Zap triggered successfully"
          }
        }
      }
      else {
        var $result {
          value = {
            success: false
            status: $zapier_response.response.status
            message: "Failed to trigger Zap"
            error: ($zapier_response.response.result ?? "Unknown error")
          }
        }
      }
    }
  }
  response = $result
}
