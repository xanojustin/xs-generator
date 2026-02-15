function "perplexity_chat_completion" {
  input {
    text prompt
    text model?= "sonar"
    boolean include_citations?= true
  }
  stack {
    // Validate API key exists
    precondition ($env.perplexity_api_key != null && $env.perplexity_api_key != "") {
      error_type = "standard"
      error = "perplexity_api_key environment variable is required"
    }

    // Build the messages array
    var $messages {
      value = [
        { role: "user", content: $input.prompt }
      ]
    }

    // Build request payload
    var $payload {
      value = {
        model: $input.model,
        messages: $messages
      }
    }

    // Add optional parameters if citations are requested
    conditional {
      if ($input.include_citations) {
        var.update $payload {
          value = $payload|set:"return_citations":true
        }
      }
    }

    // Make request to Perplexity API
    api.request {
      url = "https://api.perplexity.ai/chat/completions"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.perplexity_api_key
      ]
      timeout = 60
    } as $api_result

    // Check for successful response
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $response_data { value = $api_result.response.result }

        // Extract the assistant's message content
        var $choices { value = $response_data|get:"choices" }
        var $first_choice { value = $choices|first }
        var $message { value = $first_choice|get:"message" }
        var $content { value = $message|get:"content" }

        // Extract citations if available
        var $citations { value = $response_data|get:"citations" }

        // Build the final response
        var $result {
          value = {
            success: true,
            model: $response_data|get:"model",
            content: $content,
            citations: $citations,
            usage: $response_data|get:"usage"
          }
        }
      }
      else {
        var $error_message {
          value = "Perplexity API error (" ~ ($api_result.response.status|to_text) ~ "): " ~ ($api_result.response.result|json_encode)
        }
        throw {
          name = "APIError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}
