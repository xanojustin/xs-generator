function "anthropic_chat_completion" {
  description = "Send a chat completion request to the Anthropic Claude API"
  input {
    text model="claude-3-sonnet-20240229"
    text system?="You are a helpful assistant."
    object[] messages {
      schema {
        text role
        text content
      }
    }
    decimal temperature?=0.7
    int max_tokens?=1024
  }
  stack {
    // Validate API key is present
    precondition ($env.ANTHROPIC_API_KEY != null && $env.ANTHROPIC_API_KEY != "") {
      error_type = "standard"
      error = "ANTHROPIC_API_KEY environment variable is required"
    }

    // Build the request body
    var $request_body {
      value = {
        model: $input.model,
        max_tokens: $input.max_tokens,
        temperature: $input.temperature,
        messages: $input.messages
      }
    }

    // Add system prompt if provided
    conditional {
      if ($input.system != null && $input.system != "") {
        var $request_body {
          value = {
            model: $input.model,
            max_tokens: $input.max_tokens,
            temperature: $input.temperature,
            system: $input.system,
            messages: $input.messages
          }
        }
      }
    }

    // Make the API request to Anthropic
    api.request {
      url = "https://api.anthropic.com/v1/messages"
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "x-api-key: " ~ $env.ANTHROPIC_API_KEY,
        "anthropic-version: 2023-06-01"
      ]
      params = $request_body
      timeout = 60
    } as $api_result

    // Check for successful response
    precondition ($api_result.response.status == 200) {
      error_type = "standard"
      error = "Anthropic API request failed with status: " ~ ($api_result.response.status|to_text) ~ ", Error: " ~ ($api_result.response.result|json_encode)
    }

    // Extract the response data
    var $response_data {
      value = $api_result.response.result
    }

    // Extract the assistant's content
    var $content_blocks {
      value = $response_data.content
    }

    // Get the text content from the first block
    var $assistant_text {
      value = $content_blocks|first
    }

    // Build the result object
    var $result {
      value = {
        success: true,
        model: $response_data.model,
        content: $assistant_text.text,
        usage: {
          input_tokens: $response_data.usage.input_tokens,
          output_tokens: $response_data.usage.output_tokens
        },
        stop_reason: $response_data.stop_reason,
        id: $response_data.id
      }
    }
  }
  response = $result
}
