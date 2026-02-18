function "call_openrouter_chat" {
  input {
    text model?="anthropic/claude-3.5-sonnet"
    text message
  }
  
  stack {
    // Build the request payload for OpenRouter
    var $payload {
      value = {
        model: $input.model,
        messages: [
          {
            role: "user",
            content: $input.message
          }
        ]
      }
    }
    
    // Make the API request to OpenRouter
    api.request {
      url = "https://openrouter.ai/api/v1/chat/completions"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.OPENROUTER_API_KEY,
        "HTTP-Referer: https://xano.com",
        "X-Title: Xano OpenRouter Integration"
      ]
      timeout = 60
    } as $api_result
    
    // Check for successful response
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        // Extract the assistant's response
        var $choices { value = $api_result.response.result.choices }
        var $first_choice { value = $choices|first }
        var $assistant_message { value = $first_choice|get:"message"|get:"content" }
        var $model_used { value = $api_result.response.result.model }
        var $usage { value = $api_result.response.result.usage }
        
        // Build the response object
        var $response_data {
          value = {
            success: true,
            model: $model_used,
            message: $assistant_message,
            usage: $usage
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid OpenRouter API key. Please check your OPENROUTER_API_KEY environment variable."
        }
      }
      elseif ($api_result.response.status == 429) {
        throw {
          name = "RateLimitError"
          value = "Rate limit exceeded. Please try again later."
        }
      }
      else {
        var $error_detail { value = $api_result.response.result|json_encode }
        throw {
          name = "APIError"
          value = "OpenRouter API error (status " ~ ($api_result.response.status|to_text) ~ "): " ~ $error_detail
        }
      }
    }
  }
  
  response = $response_data
}
