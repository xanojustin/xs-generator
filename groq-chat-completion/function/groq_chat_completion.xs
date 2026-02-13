function "groq_chat_completion" {
  description = "Send a chat completion request to Groq API for fast LLM inference"
  input {
    text model="llama-3.3-70b-versatile"
    text message
  }
  stack {
    // Build the request payload for Groq API
    var $payload {
      value = {
        model: $input.model,
        messages: [
          {
            role: "user",
            content: $input.message
          }
        ],
        temperature: 0.7,
        max_tokens: 1024
      }
    }

    // Make the API request to Groq
    api.request {
      url = "https://api.groq.com/openai/v1/chat/completions"
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.groq_api_key
      ]
      params = $payload
      timeout = 30
    } as $api_result

    // Check if the request was successful
    precondition ($api_result.response.status == 200) {
      error_type = "standard"
      error = "Groq API request failed with status: " ~ $api_result.response.status|to_text
    }

    // Extract the completion result
    var $result {
      value = $api_result.response.result
    }

    // Extract the assistant's message content
    var $content {
      value = $result.choices[0].message.content
    }

    // Extract usage information
    var $usage {
      value = $result.usage
    }

    // Build the response
    var $response {
      value = {
        content: $content,
        model: $result.model,
        usage: $usage,
        id: $result.id,
        created: $result.created
      }
    }
  }
  response = $response
}
