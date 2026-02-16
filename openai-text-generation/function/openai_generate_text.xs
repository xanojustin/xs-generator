function "openai_generate_text" {
  description = "Generate text using OpenAI GPT models"
  input {
    text prompt filters=trim
    text model?="gpt-4o-mini"
    int max_tokens?=150
    decimal temperature?=0.7
  }
  stack {
    // Validate API key is available
    precondition ($env.OPENAI_API_KEY != null && $env.OPENAI_API_KEY != "") {
      error_type = "standard"
      error = "OPENAI_API_KEY environment variable is required"
    }

    // Build the request payload
    var $payload {
      value = {
        model: $input.model,
        messages: [
          { role: "system", content: "You are a helpful assistant." },
          { role: "user", content: $input.prompt }
        ],
        max_tokens: $input.max_tokens,
        temperature: $input.temperature
      }
    }

    // Make the API request to OpenAI
    api.request {
      url = "https://api.openai.com/v1/chat/completions"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.OPENAI_API_KEY
      ]
      timeout = 60
    } as $api_result

    // Handle the response
    conditional {
      if ($api_result.response.status == 200) {
        // Extract the generated text from the response
        var $generated_text {
          value = $api_result.response.result.choices|first|get:"message"|get:"content"
        }

        // Build success response
        var $api_response {
          value = {
            success: true,
            generated_text: $generated_text,
            model: $input.model,
            prompt: $input.prompt,
            usage: $api_result.response.result.usage,
            created_at: now
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid or missing OpenAI API key"
        }
      }
      elseif ($api_result.response.status == 429) {
        throw {
          name = "RateLimitError"
          value = "Rate limit exceeded - please try again later"
        }
      }
      else {
        throw {
          name = "APIError"
          value = "OpenAI API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $api_response
}