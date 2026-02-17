function "translate_text" {
  input {
    text text filters=trim
    text target_lang filters=upper|trim
    text? source_lang="" filters=upper|trim
  }
  stack {
    // Validate required inputs
    precondition ($input.text != "") {
      error_type = "inputerror"
      error = "Text to translate is required"
    }

    precondition ($input.target_lang != "") {
      error_type = "inputerror"
      error = "Target language is required"
    }

    // Build the request payload
    var $api_payload {
      value = {
        text: [$input.text]
        target_lang: $input.target_lang
      }
    }

    // Add source language if provided
    conditional {
      if ($input.source_lang != "") {
        var.update $api_payload {
          value = $api_payload|set:"source_lang":$input.source_lang
        }
      }
    }

    // Determine the API endpoint based on key type
    var $api_endpoint {
      value = "https://api-free.deepl.com/v2/translate"
    }

    conditional {
      if ($env.DEEPL_API_KEY|contains:":fx") {
        var.update $api_endpoint {
          value = "https://api-free.deepl.com/v2/translate"
        }
      }
      else {
        var.update $api_endpoint {
          value = "https://api.deepl.com/v2/translate"
        }
      }
    }

    // Make the API request to DeepL
    api.request {
      url = $api_endpoint
      method = "POST"
      params = $api_payload
      headers = [
        "Authorization: DeepL-Auth-Key " ~ $env.DEEPL_API_KEY
        "Content-Type: application/x-www-form-urlencoded"
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    conditional {
      if ($api_result.response.status == 200) {
        // Extract the translated text
        var $translations { value = $api_result.response.result.translations }
        var $first_translation { value = $translations|first }
        
        var $translated_text { 
          value = $first_translation|get:"text":""
        }
        var $detected_source_lang {
          value = $first_translation|get:"detected_source_language":""
        }

        // Determine source language for response
        var $final_source_lang { value = $detected_source_lang }
        conditional {
          if ($input.source_lang != "") {
            var.update $final_source_lang { value = $input.source_lang }
          }
        }

        // Build success result
        var $result {
          value = {
            success: true
            original_text: $input.text
            translated_text: $translated_text
            source_language: $final_source_lang
            target_language: $input.target_lang
            character_count: $api_result.response.result.character_count ?? 0
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        throw {
          name = "BadRequest"
          value = "Invalid request: " ~ ($api_result.response.result|json_encode)
        }
      }
      elseif ($api_result.response.status == 403) {
        throw {
          name = "AuthenticationError"
          value = "Invalid DeepL API key"
        }
      }
      elseif ($api_result.response.status == 429) {
        throw {
          name = "RateLimitError"
          value = "Rate limit exceeded. Please wait before retrying."
        }
      }
      elseif ($api_result.response.status == 456) {
        throw {
          name = "QuotaExceeded"
          value = "DeepL API quota exceeded. Please upgrade your plan."
        }
      }
      else {
        throw {
          name = "APIError"
          value = "DeepL API error (" ~ ($api_result.response.status|to_text) ~ "): " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $result
}