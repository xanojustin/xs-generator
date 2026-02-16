function "generate_completion" {
  input {
    text prompt filters=trim
    text model?="gpt-4o-mini" filters=trim
    int max_tokens?
    decimal temperature?
    text system_message? filters=trim
  }
  
  stack {
    // Step 1: Set defaults for optional parameters
    var $max_tokens { 
      value = $input.max_tokens ?? 150
    }
    var $temperature { 
      value = $input.temperature ?? 0.7
    }
    
    // Step 2: Validate inputs
    precondition ($input.prompt != "" && $input.prompt != null) {
      error_type = "inputerror"
      error = "Prompt is required"
    }
    
    precondition ($max_tokens > 0 && $max_tokens <= 4096) {
      error_type = "inputerror"
      error = "max_tokens must be between 1 and 4096"
    }
    
    precondition ($temperature >= 0 && $temperature <= 2) {
      error_type = "inputerror"
      error = "temperature must be between 0 and 2"
    }
    
    // Step 3: Check environment variable
    var $api_key { value = $env.OPENAI_API_KEY }
    
    precondition ($api_key != "" && $api_key != null) {
      error_type = "standard"
      error = "OPENAI_API_KEY environment variable is not set"
    }
    
    // Step 3: Build messages array
    var $messages { value = [] }
    
    // Add system message if provided
    conditional {
      if ($input.system_message != null && $input.system_message != "") {
        var $system_msg {
          value = {
            role: "system",
            content: $input.system_message
          }
        }
        var $messages {
          value = $messages|push:$system_msg
        }
      }
    }
    
    // Add user prompt
    var $user_msg {
      value = {
        role: "user",
        content: $input.prompt
      }
    }
    var $messages {
      value = $messages|push:$user_msg
    }
    
    // Step 4: Prepare API payload
    var $payload {
      value = {
        model: $input.model,
        messages: $messages,
        max_tokens: $max_tokens,
        temperature: $temperature
      }
    }
    
    // Step 5: Call OpenAI API
    api.request {
      url = "https://api.openai.com/v1/chat/completions"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
      timeout = 60
    } as $openai_response
    
    // Step 6: Handle response
    conditional {
      if ($openai_response.response.status >= 200 && $openai_response.response.status < 300) {
        var $choice { 
          value = $openai_response.response.result.choices|first
        }
        
        var $result {
          value = {
            success: true,
            content: $choice.message.content,
            model: $openai_response.response.result.model,
            prompt_tokens: $openai_response.response.result.usage.prompt_tokens,
            completion_tokens: $openai_response.response.result.usage.completion_tokens,
            total_tokens: $openai_response.response.result.usage.total_tokens,
            finish_reason: $choice.finish_reason
          }
        }
        
        // Log success
        debug.log {
          value = "OpenAI completion successful. Tokens used: " ~ ($openai_response.response.result.usage.total_tokens|to_text)
        }
      }
      else {
        // Handle API errors
        var $error_message {
          value = $openai_response.response.result.error.message ?? "Unknown OpenAI API error"
        }
        var $error_type {
          value = $openai_response.response.result.error.type ?? "unknown"
        }
        var $error_code {
          value = $openai_response.response.result.error.code ?? "unknown"
        }
        
        throw {
          name = "OpenAIAPIError"
          value = "OpenAI API error (" ~ ($openai_response.response.status|to_text) ~ ") [" ~ $error_type ~ "]: " ~ $error_message ~ " (Code: " ~ $error_code ~ ")"
        }
      }
    }
  }
  
  response = $result
}
