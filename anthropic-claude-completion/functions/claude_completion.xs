function "claude_completion" {
  description = "Send a completion request to Anthropic Claude API and return the response"
  
  input {
    text prompt filters=trim {
      description = "The user prompt to send to Claude"
    }
    
    text model?="claude-3-5-sonnet-20241022" {
      description = "Claude model to use (default: claude-3-5-sonnet-20241022)"
    }
    
    int max_tokens?=1024 filters=min:1|max:8192 {
      description = "Maximum tokens in response (default: 1024)"
    }
    
    text system_prompt?="You are a helpful, harmless, and honest AI assistant." {
      description = "Optional system prompt to guide Claude's behavior"
    }
    
    decimal temperature?=0.7 filters=min:0|max:1 {
      description = "Sampling temperature (0-1, default: 0.7)"
    }
  }
  
  stack {
    precondition (($env.anthropic_api_key|strlen) > 0) {
      error_type = "standard"
      error = "ANTHROPIC_API_KEY environment variable is required"
    }
    
    var $request_body {
      description = "Build the Anthropic API request payload"
      value = {
        model: $input.model,
        messages: [
          {
            role: "user",
            content: $input.prompt
          }
        ],
        max_tokens: $input.max_tokens,
        temperature: $input.temperature,
        system: $input.system_prompt
      }|json_encode
    }
    
    debug.log {
      description = "Log the request being sent"
      value = "Sending completion request to Anthropic Claude with model: " ~ $input.model
    }
    
    api.request {
      description = "Make the Anthropic Messages API call"
      url = "https://api.anthropic.com/v1/messages"
      method = "POST"
      params = $request_body
      headers = [
        "Content-Type: application/json",
        "x-api-key: " ~ $env.anthropic_api_key,
        "anthropic-version: 2023-06-01"
      ]
    } as $api_response
    
    var $response_status {
      description = "Extract HTTP status from response"
      value = $api_response.response.status
    }
    
    precondition ($response_status == 200) {
      error_type = "standard"
      error = "Anthropic API error: " ~ ($api_response.response.body.error.message ?? "Unknown error")
    }
    
    var $response_body {
      description = "Extract response body"
      value = $api_response.response.body
    }
    
    var $content {
      description = "Extract content from API response"
      value = $response_body|get:"content":null
    }
    
    precondition ($content != null && ($content|count) > 0) {
      error_type = "standard"
      error = "No content returned from Anthropic Claude"
    }
    
    var $message_content {
      description = "Extract the assistant's message content"
      value = $content|first|get:"text":""
    }
    
    var $usage {
      description = "Extract token usage information"
      value = $response_body|get:"usage":{}
    }
    
    var $result {
      description = "Build the response object"
      value = {
        success: true,
        response: $message_content,
        model: $response_body|get:"model":"unknown",
        usage: $usage,
        input_tokens: $usage|get:"input_tokens":0,
        output_tokens: $usage|get:"output_tokens":0
      }
    }
    
    debug.log {
      description = "Log successful completion"
      value = "Claude completion successful. Input tokens: " ~ (($usage|get:"input_tokens":0)|to_text) ~ ", Output tokens: " ~ (($usage|get:"output_tokens":0)|to_text)
    }
  }
  
  response = $result
}
