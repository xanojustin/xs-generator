function "chat_completion" {
  description = "Generate a chat completion using Anthropic's Claude API"
  input {
    text prompt filters=trim { description = "The user's prompt/message to send to Claude" }
    text model?="claude-3-5-sonnet-20241022" filters=trim { description = "Claude model to use (default: claude-3-5-sonnet-20241022)" }
    text system_message? filters=trim { description = "Optional system message to set Claude's behavior" }
    text max_tokens?="1000" filters=trim { description = "Maximum tokens to generate (default: 1000)" }
    text temperature?="0.7" filters=trim { description = "Sampling temperature 0-1 (default: 0.7)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.ANTHROPIC_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "ANTHROPIC_API_KEY environment variable not configured"
    }

    // Validate prompt is provided
    precondition ($input.prompt != null && $input.prompt != "") {
      error_type = "inputerror"
      error = "Prompt is required"
    }

    // Build the request payload
    var $payload {
      value = {
        model: $input.model,
        max_tokens: $input.max_tokens,
        temperature: $input.temperature,
        messages: [
          {
            role: "user",
            content: $input.prompt
          }
        ]
      }
    }

    // Add system message if provided
    conditional {
      if ($input.system_message != null && $input.system_message != "") {
        var.update $payload {
          value = $payload|set:"system":$input.system_message
        }
      }
    }

    // Send the request to Anthropic
    api.request {
      url = "https://api.anthropic.com/v1/messages"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "x-api-key: " ~ $api_key,
        "anthropic-version: 2023-06-01"
      ]
      timeout = 60
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $completion_text { value = null }
    var $usage { value = null }
    var $error_message { value = null }
    var $stop_reason { value = null }
    var $message_id { value = null }
    var $model_used { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $usage { value = $response_body|get:"usage" }
        var $message_id { value = $response_body|get:"id" }
        var $model_used { value = $response_body|get:"model" }
        var $stop_reason { value = $response_body|get:"stop_reason" }

        // Extract the completion text from content array
        var $content_array { value = $response_body|get:"content" }
        conditional {
          if ($content_array != null && ($content_array|count) > 0) {
            var $first_content { value = $content_array|first }
            conditional {
              if ($first_content != null) {
                var $completion_text { value = $first_content|get:"text" }
              }
            }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_body { value = $api_result.response.result }
        conditional {
          if ($error_body != null) {
            var $error_obj { value = $error_body|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_message { value = $error_obj|get:"message" }
              }
              else {
                var $error_message {
                  value = "Anthropic API error: HTTP " ~ ($api_result.response.status|to_text)
                }
              }
            }
          }
          else {
            var $error_message {
              value = "Anthropic API error: HTTP " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    completion: $completion_text,
    message_id: $message_id,
    model: $model_used,
    usage: $usage,
    stop_reason: $stop_reason,
    error: $error_message
  }
}