function "groq_chat_completion" {
  description = "Send a chat completion request to Groq API for fast AI inference"
  input {
    text model?="llama-3.3-70b-versatile" { description = "Groq model to use" }
    text message filters=trim { description = "User message to send to the model" }
    decimal temperature?=0.7 filters=min:0|max:2 { description = "Sampling temperature" }
    int max_tokens?=1024 filters=min:1|max:8192 { description = "Maximum tokens to generate" }
  }
  stack {
    var $response_content { value = null }
    var $usage { value = null }
    var $model_used { value = null }

    api.request {
      url = "https://api.groq.com/openai/v1/chat/completions"
      method = "POST"
      params = {
        model: $input.model,
        messages: [
          { role: "system", content: "You are a helpful assistant." },
          { role: "user", content: $input.message }
        ],
        temperature: $input.temperature,
        max_tokens: $input.max_tokens
      }
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.GROQ_API_KEY
      ]
    } as $api_result

    conditional {
      if ($api_result.response.status == 200) {
        var.update $response_content { 
          value = $api_result.response.result.choices|first|get:"message"|get:"content" 
        }
        var.update $usage { 
          value = $api_result.response.result.usage 
        }
        var.update $model_used { 
          value = $api_result.response.result.model 
        }
      }
      else {
        throw {
          name = "GroqAPIError"
          value = "Groq API error: " ~ ($api_result.response.status|to_text)
        }
      }
    }

    var $result { value = { success: true, model: $model_used, message: $response_content, usage: $usage } }
  }
  response = $result
}
