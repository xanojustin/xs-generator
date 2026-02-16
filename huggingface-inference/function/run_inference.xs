function "run_inference" {
  description = "Run ML inference using Hugging Face Inference API"
  input {
    text model filters=trim { 
      description = "Hugging Face model ID (e.g., facebook/bart-large-mnli, distilbert-base-uncased)" 
    }
    text text filters=trim { 
      description = "Input text for the ML model" 
    }
    text[] candidate_labels? { 
      description = "Candidate labels for zero-shot classification (required for classification models)" 
    }
    bool wait_for_model? = true { 
      description = "Whether to wait if model is loading (default: true)" 
    }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.HUGGINGFACE_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "HUGGINGFACE_API_KEY environment variable not configured"
    }

    // Validate required inputs
    precondition ($input.model != null && $input.model != "") {
      error_type = "inputerror"
      error = "Model ID is required"
    }

    precondition ($input.text != null && $input.text != "") {
      error_type = "inputerror"
      error = "Input text is required"
    }

    // Build the request payload based on input type
    var $payload { value = {} }

    conditional {
      if ($input.candidate_labels != null && ($input.candidate_labels|count) > 0) {
        // Zero-shot classification payload
        var $payload {
          value = {
            inputs: $input.text,
            parameters: { candidate_labels: $input.candidate_labels }
          }
        }
      }
      else {
        // Standard text classification/sentiment analysis payload
        var $payload {
          value = {
            inputs: $input.text
          }
        }
      }
    }

    // Build headers
    var $headers {
      value = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
    }

    conditional {
      if ($input.wait_for_model == true) {
        var.update $headers {
          value = $headers|push:"X-Wait-For-Model: true"
        }
      }
    }

    // Send the request to Hugging Face Inference API
    api.request {
      url = "https://api-inference.huggingface.co/models/" ~ $input.model
      method = "POST"
      params = $payload
      headers = $headers
      timeout = 120
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $result { value = null }
    var $error_message { value = null }
    var $is_classification { value = false }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $success { value = true }
        var $response_body { value = $api_result.response.result }

        // Handle different response formats
        conditional {
          // Check if it's an array (standard HF response)
          if ($response_body|is_array) {
            var $first_item { value = $response_body|first }
            
            // Check if it's a classification result with labels/scores
            conditional {
              if ($first_item|is_array) {
                var $is_classification { value = true }
                var $result { value = $first_item }
              }
              else {
                var $result { value = $response_body }
              }
            }
          }
          else {
            var $result { value = $response_body }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_body { value = $api_result.response.result }
        
        conditional {
          if ($error_body != null && ($error_body|is_object)) {
            var $error_msg { value = $error_body|get:"error" }
            conditional {
              if ($error_msg != null) {
                var $error_message { value = $error_msg }
              }
              else {
                var $estimated_time { value = $error_body|get:"estimated_time" }
                conditional {
                  if ($estimated_time != null) {
                    var $error_message {
                      value = "Model is currently loading. Estimated time: " ~ ($estimated_time|to_text) ~ " seconds. Try again shortly."
                    }
                  }
                  else {
                    var $error_message {
                      value = "Hugging Face API error: HTTP " ~ ($api_result.response.status|to_text)
                    }
                  }
                }
              }
            }
          }
          else {
            var $error_message {
              value = "Hugging Face API error: HTTP " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    result: $result,
    is_classification: $is_classification,
    model: $input.model,
    error: $error_message
  }
}
