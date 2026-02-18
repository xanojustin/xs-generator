function "generate_completion" {
  description = "Generate a text completion using OpenAI's Chat Completions API"
  input {
    text prompt filters=trim { description = "The prompt/message to send to OpenAI" }
    text model?="gpt-4o-mini" filters=trim { description = "OpenAI model to use (e.g., gpt-4o, gpt-4o-mini)" }
    int max_tokens?=150 filters=min:1|max:4096 { description = "Maximum tokens in the response" }
    decimal temperature?=0.7 filters=min:0|max:2 { description = "Sampling temperature (0-2, lower = more focused)" }
  }
  stack {
    var $request_body {
      value = {
        model: $input.model,
        messages: [
          { role: "user", content: $input.prompt }
        ],
        max_tokens: $input.max_tokens,
        temperature: $input.temperature
      }
    }

    api.request {
      url = "https://api.openai.com/v1/chat/completions"
      method = "POST"
      params = $request_body
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.OPENAI_API_KEY
      ]
      timeout = 60
    } as $api_result

    conditional {
      if ($api_result.response.status == 200) {
        var $completion { value = $api_result.response.result }
        var $message_content { 
          value = $completion.choices|first|get:"message"|get:"content" 
        }
        var $usage { value = $completion.usage }

        db.add completion_log {
          data = {
            prompt: $input.prompt,
            model: $input.model,
            completion: $message_content,
            prompt_tokens: $usage.prompt_tokens,
            completion_tokens: $usage.completion_tokens,
            total_tokens: $usage.total_tokens,
            status: "success",
            created_at: now
          }
        } as $log_entry

        var $result {
          value = {
            success: true,
            completion: $message_content,
            model: $completion.model,
            usage: $usage,
            log_id: $log_entry.id
          }
        }
      }
      else {
        var $error_message {
          value = "OpenAI API error: " ~ ($api_result.response.result.error.message|to_text)
        }

        db.add completion_log {
          data = {
            prompt: $input.prompt,
            model: $input.model,
            status: "failed",
            error_message: $error_message,
            http_status: $api_result.response.status,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "OpenAIError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}
