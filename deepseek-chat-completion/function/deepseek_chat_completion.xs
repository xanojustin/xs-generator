function "deepseek_chat_completion" {
  description = "Generate chat completions using the DeepSeek AI API"
  input {
    text model { 
      description = "DeepSeek model to use (e.g., 'deepseek-chat', 'deepseek-coder')"
    }
    text message { 
      description = "The user message/prompt to send to DeepSeek"
    }
    decimal temperature { 
      description = "Sampling temperature (0.0 to 2.0). Higher = more random"
    }
    int max_tokens { 
      description = "Maximum number of tokens to generate"
    }
  }
  stack {
    // Set defaults for optional parameters
    var $model_name {
      value = $input.model != null && $input.model != "" ? $input.model : "deepseek-chat"
    }
    var $temp {
      value = $input.temperature != null ? $input.temperature : 0.7
    }
    var $max_tok {
      value = $input.max_tokens != null ? $input.max_tokens : 1000
    }
    
    // Validate inputs
    precondition ($input.message != null && $input.message != "") {
      error_type = "inputerror"
      error = "Message content is required"
    }
    
    // Validate temperature range
    precondition ($temp >= 0.0 && $temp <= 2.0) {
      error_type = "inputerror"
      error = "Temperature must be between 0.0 and 2.0"
    }
    
    // Get API key from environment
    var $api_key { value = $env.deepseek_api_key }
    
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "DeepSeek API key is not configured. Set deepseek_api_key environment variable."
    }
    
    // Build the request payload
    var $payload {
      value = {
        model: $model_name,
        messages: [
          {
            role: "user",
            content: $input.message
          }
        ],
        temperature: $temp,
        max_tokens: $max_tok
      }
    }
    
    // Make the API request to DeepSeek
    api.request {
      url = "https://api.deepseek.com/v1/chat/completions"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
      timeout = 60
    } as $api_response
    
    // Handle response
    conditional {
      if ($api_response.response.status == 200) {
        // Success - extract the completion
        var $choice { value = $api_response.response.result.choices[0] }
        var $result {
          value = {
            success: true,
            content: $choice.message.content,
            model: $api_response.response.result.model,
            usage: $api_response.response.result.usage,
            finish_reason: $choice.finish_reason
          }
        }
      }
      elseif ($api_response.response.status == 401) {
        throw {
          name = "DeepSeekAuthError"
          value = "Authentication failed. Check your DeepSeek API key."
        }
      }
      elseif ($api_response.response.status == 429) {
        throw {
          name = "DeepSeekRateLimitError"
          value = "Rate limit exceeded. Please try again later."
        }
      }
      elseif ($api_response.response.status >= 400 && $api_response.response.status < 500) {
        var $error_msg {
          value = "Client error: " ~ ($api_response.response.status|to_text)
        }
        throw {
          name = "DeepSeekClientError"
          value = $error_msg
        }
      }
      else {
        var $error_msg {
          value = "Server error: " ~ ($api_response.response.status|to_text)
        }
        throw {
          name = "DeepSeekAPIError"
          value = $error_msg
        }
      }
    }
  }
  response = $result
}
