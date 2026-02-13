function "openai_chat_completion" {
  description = "Send a chat completion request to the OpenAI API"
  input {
    text model="gpt-4o"
    object[] messages {
      schema {
        text role
        text content
      }
    }
    decimal temperature?=0.7
    int max_tokens?=150
  }
  stack {
    // Validate API key is present
    precondition ($env.OPENAI_API_KEY != null && $env.OPENAI_API_KEY != "") {
      error_type = "standard"
      error = "OPENAI_API_KEY environment variable is required"
    }

    // Make the API request to OpenAI
    api.request {
      url = "https://api.openai.com/v1/chat/completions"
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.OPENAI_API_KEY
      ]
      params = {
        model: $input.model,
        messages: $input.messages,
        temperature: $input.temperature,
        max_tokens: $input.max_tokens
      }
      timeout = 60
    } as $api_result

    // Check for successful response
    precondition ($api_result.response.status == 200) {
      error_type = "standard"
      error = "OpenAI API request failed with status: " ~ $api_result.response.status|to_text
    }

    // Extract the response data
    var $response_data {
      value = $api_result.response.result
    }

    // Extract the assistant's message
    var $assistant_message {
      value = $response_data.choices|first
    }

    // Build the result object
    var $result {
      value = {
        success: true,
        model: $response_data.model,
        content: $assistant_message.message.content,
        usage: $response_data.usage,
        finish_reason: $assistant_message.finish_reason
      }
    }
  }
  response = $result
}
