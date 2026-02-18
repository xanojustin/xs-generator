function "replicate_run_prediction" {
  description = "Run an AI model prediction on Replicate and optionally wait for completion"
  input {
    text model { description = "Replicate model identifier (e.g., 'black-forest-labs/flux-schnell')" }
    json input_data { description = "Model-specific input parameters" }
    bool wait_for_completion? = true { description = "Whether to wait for the prediction to complete" }
    int poll_interval? = 1 { description = "Seconds between status polls when waiting" }
    int max_poll_attempts? = 60 { description = "Maximum number of polling attempts" }
  }
  stack {
    // Create the prediction
    api.request {
      url = "https://api.replicate.com/v1/models/" ~ $input.model ~ "/predictions"
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.REPLICATE_API_TOKEN,
        "Prefer: wait=false"
      ]
      params = {
        input: $input.input_data
      }
      timeout = 30
    } as $create_result

    // Check if creation succeeded
    precondition ($create_result.response.status == 201 || $create_result.response.status == 200) {
      error_type = "standard"
      error = "Failed to create prediction: " ~ ($create_result.response.status|to_text)
    }

    var $prediction { value = $create_result.response.result }
    var $prediction_id { value = $prediction.id }
    var $prediction_status { value = $prediction.status }

    debug.log { value = "Created prediction with ID: " ~ $prediction_id }
    debug.log { value = "Initial status: " ~ $prediction_status }

    // Variable to hold final result
    var $result_data { value = null }

    // If not waiting, return immediately
    conditional {
      if (!$input.wait_for_completion) {
        var $result_data {
          value = {
            prediction_id: $prediction_id
            status: $prediction_status
            urls: $prediction.urls
            message: "Prediction created. Check status using the prediction ID."
          }
        }
      }
    }

    // Wait for completion if requested
    conditional {
      if ($input.wait_for_completion) {
        var $completed { value = false }
        var $attempts { value = 0 }
        var $poll_prediction { value = $prediction }

        while (!$completed && $attempts < $input.max_poll_attempts) {
          each {
            // Poll for status
            api.request {
              url = "https://api.replicate.com/v1/predictions/" ~ $prediction_id
              method = "GET"
              headers = [
                "Authorization: Bearer " ~ $env.REPLICATE_API_TOKEN
              ]
              timeout = 30
            } as $poll_result

            precondition ($poll_result.response.status == 200) {
              error_type = "standard"
              error = "Failed to poll prediction status"
            }

            var $poll_data { value = $poll_result.response.result }
            var $current_status { value = $poll_data.status }

            debug.log { value = "Poll attempt " ~ (($attempts + 1)|to_text) ~ ": status = " ~ $current_status }

            // Check if completed
            conditional {
              if ($current_status == "succeeded" || $current_status == "failed" || $current_status == "canceled") {
                var $completed { value = true }
                var $poll_prediction { value = $poll_data }
              }
            }

            var.update $attempts { value = $attempts + 1 }

            // Sleep before next poll if not complete
            conditional {
              if (!$completed && $attempts < $input.max_poll_attempts) {
                util.sleep { value = $input.poll_interval }
              }
            }
          }
        }

        // Check final status
        conditional {
          if ($poll_prediction.status == "succeeded") {
            debug.log { value = "Prediction completed successfully" }
          }
          elseif ($poll_prediction.status == "failed") {
            debug.log { value = "Prediction failed: " ~ ($poll_prediction.error ?? "Unknown error") }
          }
          elseif ($poll_prediction.status == "canceled") {
            debug.log { value = "Prediction was canceled" }
          }
          else {
            debug.log { value = "Prediction timed out after " ~ ($input.max_poll_attempts|to_text) ~ " attempts" }
          }
        }

        var $result_data {
          value = {
            prediction_id: $poll_prediction.id
            status: $poll_prediction.status
            model: $input.model
            input: $poll_prediction.input
            output: $poll_prediction.output
            error: $poll_prediction.error ?? null
            created_at: $poll_prediction.created_at
            completed_at: $poll_prediction.completed_at ?? null
            urls: $poll_prediction.urls
            metrics: $poll_prediction.metrics ?? null
          }
        }
      }
    }
  }
  response = $result_data
}
