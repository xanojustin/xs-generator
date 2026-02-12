function "openai_chat" {
  description = "Send a chat completion request to OpenAI API and return the response"
  
  input {
    text prompt filters=trim {
      description = "The user prompt to send to OpenAI"
    }
    
    text model?="gpt-4o-mini" {
      description = "OpenAI model to use (default: gpt-4o-mini)"
    }
    
    decimal temperature?=0.7 filters=min:0|max:2 {
      description = "Sampling temperature (0-2, default: 0.7)"
    }
    
    int max_tokens?=500 filters=min:1|max:4096 {
      description = "Maximum tokens in response (default: 500)"
    }
  }
  
  stack {
    precondition (($env.openai_api_key|strlen) > 0) {
      error_type = "standard"
      error = "OPENAI_API_KEY environment variable is required"
    }
    
    var $request_body {
      description = "Build the OpenAI API request payload"
      value = {
        model: $input.model,
        messages: [
          {
            role: "system",
            content: "You are a helpful assistant."
          },
          {
            role: "user",
            content: $input.prompt
          }
        ],
        temperature: $input.temperature,
        max_tokens: $input.max_tokens
      }|json_encode
    }
    
    debug.log {
      description = "Log the request being sent"
      value = "Sending chat completion request to OpenAI with model: " ~ $input.model
    }
    
    api.request {
      description = "Make the OpenAI chat completions API call"
      url = "https://api.openai.com/v1/chat/completions"
      method = "POST"
      params = $request_body
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.openai_api_key
      ]
    } as $api_response
    
    var $choices {
      description = "Extract choices from API response"
      value = $api_response|get:"choices":null
    }
    
    precondition ($choices != null && ($choices|count) > 0) {
      error_type = "standard"
      error = "No completion choices returned from OpenAI"
    }
    
    var $message_content {
      description = "Extract the assistant's message content"
      value = $choices|first|get:"message.content":""
    }
    
    var $usage {
      description = "Extract token usage information"
      value = $api_response|get:"usage":{}
    }
    
    var $result {
      description = "Build the response object"
      value = {
        success: true,
        response: $message_content,
        model: $api_response|get:"model":"unknown",
        usage: $usage,
        prompt_tokens: $usage|get:"prompt_tokens":0,
        completion_tokens: $usage|get:"completion_tokens":0,
        total_tokens: $usage|get:"total_tokens":0
      }
    }
    
    debug.log {
      description = "Log successful completion"
      value = "OpenAI chat completion successful. Tokens used: " ~ ($usage|get:"total_tokens":0)|to_text
    }
  }
  
  response = $result
}
