function "chat_completion" {
  description = "Generate a chat completion using OpenAI's GPT API"
  input {
    text prompt filters=trim { description = "The user's prompt/message to send to the AI" }
    text model?="gpt-4o-mini" filters=trim { description = "OpenAI model to use (default: gpt-4o-mini)" }
    text system_message? filters=trim { description = "Optional system message to set AI behavior" }
    text temperature?="0.7" filters=trim { description = "Sampling temperature 0-2 (default: 0.7)" }
    text max_tokens?="1000" filters=trim { description = "Maximum tokens to generate (default: 1000)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.OPENAI_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "OPENAI_API_KEY environment variable not configured"
    }

    // Validate prompt is provided
    precondition ($input.prompt != null && $input.prompt != "") {
      error_type = "inputerror"
      error = "Prompt is required"
    }

    // Build messages array
    var $messages { value = [] }

    // Add system message if provided
    conditional {
      if ($input.system_message != null && $input.system_message != "") {
        var.update $messages {
          value = $messages|push:{
            role: "system",
            content: $input.system_message
          }
        }
      }
    }

    // Add user prompt
    var.update $messages {
      value = $messages|push:{
        role: "user",
        content: $input.prompt
      }
    }

    // Build the request payload
    var $payload {
      value = {
        model: $input.model,
        messages: $messages,
        temperature: $input.temperature,
        max_tokens: $input.max_tokens
      }
    }

    // Send the request to OpenAI
    api.request {
      url = "https://api.openai.com/v1/chat/completions"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
      timeout = 60
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $completion_text { value = null }
    var $usage { value = null }
    var $error_message { value = null }
    var $finish_reason { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $usage { value = $response_body|get:"usage" }

        // Extract the completion text from choices
        var $choices { value = $response_body|get:"choices" }
        conditional {
          if ($choices != null && ($choices|count) > 0) {
            var $first_choice { value = $choices|first }
            var $message_obj { value = $first_choice|get:"message" }
            conditional {
              if ($message_obj != null) {
                var $completion_text { value = $message_obj|get:"content" }
                var $finish_reason { value = $first_choice|get:"finish_reason" }
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
                  value = "OpenAI API error: HTTP " ~ ($api_result.response.status|to_text)
                }
              }
            }
          }
          else {
            var $error_message {
              value = "OpenAI API error: HTTP " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    completion: $completion_text,
    usage: $usage,
    finish_reason: $finish_reason,
    error: $error_message
  }
}
