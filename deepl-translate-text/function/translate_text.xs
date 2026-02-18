function "translate_text" {
  description = "Translate text using the DeepL API"
  input {
    text text filters=trim { description = "Text to translate" }
    text target_lang filters=trim|upper { description = "Target language code (e.g., ES, DE, FR, JA)" }
    text source_lang?="AUTO" filters=trim|upper { description = "Source language code (e.g., EN, ES, DE) or AUTO for auto-detection" }
  }
  stack {
    var $api_url {
      value = "https://api-free.deepl.com/v2/translate"
    }

    conditional {
      if ($env.DEEPL_API_KEY|contains:":fx") {
        var $api_url { value = "https://api-free.deepl.com/v2/translate" }
      }
      else {
        var $api_url { value = "https://api.deepl.com/v2/translate" }
      }
    }

    var $payload {
      value = {
        text: [$input.text],
        target_lang: $input.target_lang
      }
    }

    conditional {
      if ($input.source_lang != "AUTO") {
        var.update $payload { value = $payload|set:"source_lang":$input.source_lang }
      }
    }

    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: DeepL-Auth-Key " ~ $env.DEEPL_API_KEY
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $translation { value = $api_result.response.result.translations|first }

        db.add translation_log {
          data = {
            source_text: $input.text,
            translated_text: $translation|get:"text",
            source_lang: $translation|get:"detected_source_language",
            target_lang: $input.target_lang,
            status: "success",
            created_at: now
          }
        } as $log_entry

        var $result {
          value = {
            success: true,
            original_text: $input.text,
            translated_text: $translation|get:"text",
            detected_source_language: $translation|get:"detected_source_language",
            target_language: $input.target_lang,
            log_id: $log_entry.id
          }
        }
      }
      else {
        var $error_message {
          value = "DeepL API error: " ~ ($api_result.response.result.message ?? "Unknown error")
        }

        db.add translation_log {
          data = {
            source_text: $input.text,
            target_lang: $input.target_lang,
            status: "failed",
            error_message: $error_message,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "DeepLError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}
