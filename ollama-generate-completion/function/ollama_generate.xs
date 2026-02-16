function "ollama_generate" {
  input {
    text model
    text prompt
    bool stream?=false
  }
  stack {
    // Validate required inputs
    precondition ($input.model != null && $input.model != "") {
      error_type = "inputerror"
      error = "Model name is required"
    }

    precondition ($input.prompt != null && $input.prompt != "") {
      error_type = "inputerror"
      error = "Prompt is required"
    }

    // Get base URL from environment with default
    var $base_url {
      value = $env.OLLAMA_BASE_URL ?? "http://localhost:11434"
    }

    // Build the API URL
    var $api_url {
      value = $base_url ~ "/api/generate"
    }

    // Prepare request payload
    var $payload {
      value = {
        model: $input.model,
        prompt: $input.prompt,
        stream: $input.stream
      }
    }

    // Make the API request to Ollama
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = ["Content-Type: application/json"]
      timeout = 120
    } as $api_result

    // Check for successful response
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "Ollama API error: " ~ ($api_result.response.status|to_text)
    }

    // Extract the response
    var $ollama_response {
      value = $api_result.response.result
    }

    // Log the generation to database
    var $truncated_prompt { value = $input.prompt }
    conditional {
      if (`($input.prompt|strlen) > 500`) {
        var.update $truncated_prompt { value = $input.prompt|substr:0:500 }
      }
    }

    var $response_text { value = $ollama_response.response }
    var $truncated_response { value = $response_text }
    conditional {
      if (`($response_text|strlen) > 1000`) {
        var.update $truncated_response { value = $response_text|substr:0:1000 }
      }
    }

    db.add "generation_log" {
      data = {
        model: $input.model,
        prompt: $truncated_prompt,
        response: $truncated_response,
        total_duration: $ollama_response.total_duration ?? null,
        load_duration: $ollama_response.load_duration ?? null,
        prompt_eval_count: $ollama_response.prompt_eval_count ?? null,
        eval_count: $ollama_response.eval_count ?? null,
        created_at: now
      }
    } as $log_entry

    // Build success response
    var $result {
      value = {
        success: true,
        model: $ollama_response.model,
        response: $ollama_response.response,
        done: $ollama_response.done,
        timing: {
          total_duration_ms: ($ollama_response.total_duration ?? 0) / 1000000,
          load_duration_ms: ($ollama_response.load_duration ?? 0) / 1000000,
          prompt_eval_count: $ollama_response.prompt_eval_count ?? 0,
          eval_count: $ollama_response.eval_count ?? 0
        },
        log_id: $log_entry.id
      }
    }
  }
  response = $result
}
