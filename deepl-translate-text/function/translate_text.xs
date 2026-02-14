function "translate_text" {
  input {
    text text
    text target_lang
    text source_lang?
  }
  stack {
    // Validate inputs
    precondition ($input.text != null && $input.text != "") {
      error_type = "inputerror"
      error = "text is required"
    }

    precondition ($input.target_lang != null && $input.target_lang != "") {
      error_type = "inputerror"
      error = "target_lang is required (e.g., ES, FR, DE, JA)"
    }

    // Build the request payload
    var $payload {
      value = {
        text: [$input.text],
        target_lang: $input.target_lang|to_upper
      }
    }

    // Add source language if provided
    conditional {
      if ($input.source_lang != null && $input.source_lang != "") {
        var.update $payload {
          value = $payload|set:"source_lang":($input.source_lang|to_upper)
        }
      }
    }

    // Make the API request to DeepL
    api.request {
      url = "https://api-free.deepl.com/v2/translate"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: DeepL-Auth-Key " ~ $env.deepl_api_key
      ]
      timeout = 30
    } as $deepl_response

    // Check response status
    conditional {
      if ($deepl_response.response.status == 200) {
        var $translation {
          value = $deepl_response.response.result.translations|first
        }
        var $result {
          value = {
            success: true,
            translated_text: $translation|get:"text",
            detected_source_language: $translation|get:"detected_source_language",
            target_language: $input.target_lang|to_upper
          }
        }
      }
      else {
        var $error_message {
          value = "DeepL API error: " ~ ($deepl_response.response.status|to_text)
        }
        conditional {
          if ($deepl_response.response.result.message != null) {
            var.update $error_message {
              value = $error_message ~ " - " ~ $deepl_response.response.result.message
            }
          }
        }
        throw {
          name = "DeepLError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}