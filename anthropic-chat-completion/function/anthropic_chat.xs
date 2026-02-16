function "anthropic_chat" {
  description = "Send a chat completion request to the Anthropic Claude API"
  input {
    text model filters=trim
    int max_tokens
    json messages
    text system filters=trim
    decimal temperature
  }
  stack {
    // Set default values if not provided
    var $use_model {
      value = ($input.model != null && $input.model != "") ? $input.model : "claude-3-5-sonnet-20241022"
    }
    
    var $use_max_tokens {
      value = ($input.max_tokens != null && $input.max_tokens > 0) ? $input.max_tokens : 1024
    }

    var $payload {
      value = {
        model: $use_model,
        max_tokens: $use_max_tokens,
        messages: $input.messages
      }
    }

    conditional {
      if (($input.system != null) && (($input.system|strlen) > 0)) {
        var $payload_with_system {
          value = $payload ~ {system: $input.system}
        }
        var $payload { value = $payload_with_system }
      }
    }

    conditional {
      if ($input.temperature != null) {
        var $payload_with_temp {
          value = $payload ~ {temperature: $input.temperature}
        }
        var $payload { value = $payload_with_temp }
      }
    }

    api.request {
      url = "https://api.anthropic.com/v1/messages"
      method = "POST"
      params = $payload
      headers = [
        "x-api-key: " ~ $env.anthropic_api_key,
        "Content-Type: application/json",
        "anthropic-version: 2023-06-01"
      ]
      timeout = 60
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $claude_response { value = $api_result.response.result }
      }
      else {
        throw {
          name = "AnthropicAPIError"
          value = "Anthropic API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $claude_response
}
