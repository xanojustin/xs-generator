function "run_prediction" {
  description = "Run a prediction on a Replicate AI model"
  input {
    text model filters=trim { description = "Replicate model identifier (e.g., black-forest-labs/flux-schnell)" }
    text prompt filters=trim { description = "Input prompt for the model" }
    text webhook_url? filters=trim { description = "Optional webhook URL to receive completion notifications" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.REPLICATE_API_TOKEN }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "REPLICATE_API_TOKEN environment variable not configured"
    }

    // Validate required inputs
    precondition ($input.model != null && $input.model != "") {
      error_type = "inputerror"
      error = "Model identifier is required (e.g., black-forest-labs/flux-schnell)"
    }

    precondition ($input.prompt != null && $input.prompt != "") {
      error_type = "inputerror"
      error = "Prompt is required"
    }

    // Build input data with prompt
    var $input_data {
      value = { prompt: $input.prompt }
    }

    // Build the request payload
    var $payload {
      value = {
        version: $input.model,
        input: $input_data
      }
    }

    // Add webhook if provided
    conditional {
      if ($input.webhook_url != null && $input.webhook_url != "") {
        var.update $payload {
          value = $payload|set:"webhook":$input.webhook_url
        }
      }
    }

    // Create the prediction
    api.request {
      url = "https://api.replicate.com/v1/predictions"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Token " ~ $api_key
      ]
      timeout = 60
    } as $create_result

    // Initialize response variables
    var $success { value = false }
    var $prediction_id { value = null }
    var $status { value = null }
    var $prediction_output { value = null }
    var $error_message { value = null }
    var $urls { value = null }
    var $logs { value = null }

    // Parse creation response
    conditional {
      if ($create_result.response.status == 200 || $create_result.response.status == 201) {
        var $response_body { value = $create_result.response.result }
        var $success { value = true }
        var $prediction_id { value = $response_body|get:"id" }
        var $status { value = $response_body|get:"status" }
        var $prediction_output { value = $response_body|get:"output" }
        var $urls { value = $response_body|get:"urls" }
        var $logs { value = $response_body|get:"logs" }

        // Handle failed status
        conditional {
          if ($status == "failed") {
            var $success { value = false }
            var $error_obj { value = $response_body|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_message { value = $error_obj|get:"detail" }
              }
              else {
                var $error_message { value = "Prediction failed" }
              }
            }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_body { value = $create_result.response.result }
        conditional {
          if ($error_body != null) {
            var $error_obj { value = $error_body|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_message { value = $error_obj|get:"detail" }
              }
              else {
                var $error_message {
                  value = "Replicate API error: HTTP " ~ ($create_result.response.status|to_text)
                }
              }
            }
          }
          else {
            var $error_message {
              value = "Replicate API error: HTTP " ~ ($create_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    prediction_id: $prediction_id,
    status: $status,
    output: $prediction_output,
    urls: $urls,
    logs: $logs,
    error: $error_message
  }
}
