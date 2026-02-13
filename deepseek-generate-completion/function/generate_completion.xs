function "generate_completion" {
  description = "Generate a text completion using the DeepSeek API"
  input {
    text prompt { description = "The user prompt to send to DeepSeek" }
    text model?="deepseek-chat" { description = "Model to use (default: deepseek-chat)" }
    decimal temperature?=0.7 { description = "Sampling temperature (0-2)" }
    int max_tokens?=1024 { description = "Maximum tokens to generate" }
  }
  stack {
    // Build the request payload
    var $payload {
      value = {
        model: $input.model,
        messages: [
          { role: "system", content: "You are a helpful assistant." },
          { role: "user", content: $input.prompt }
        ],
        temperature: $input.temperature,
        max_tokens: $input.max_tokens
      }
    }

    // Make the API request to DeepSeek
    api.request {
      url = "https://api.deepseek.com/chat/completions"
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.deepseek_api_key
      ]
      params = $payload
      timeout = 60
    } as $api_response

    // Check for successful response
    precondition ($api_response.response.status == 200) {
      error_type = "standard"
      error = "DeepSeek API request failed with status: " ~ $api_response.response.status|to_text
    }

    // Extract the completion text
    var $response_body { value = $api_response.response.result }
    var $completion_text { value = $response_body.choices[0].message.content }
    var $usage { value = $response_body.usage }
    var $model_used { value = $response_body.model }
  }
  response = {
    completion: $completion_text,
    model: $model_used,
    usage: $usage,
    success: true
  }
}
