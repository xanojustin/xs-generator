function "elevenlabs_generate_speech" {
  description = "Generate speech from text using ElevenLabs API"
  input {
    text text filters=trim
    text voice_id?="21m00Tcm4TlvDq8ikWAM"
    text model_id?="eleven_monolingual_v1"
    decimal stability?=0.5
    decimal similarity_boost?=0.75
  }
  stack {
    // Validate API key is available
    precondition ($env.ELEVENLABS_API_KEY != null && $env.ELEVENLABS_API_KEY != "") {
      error_type = "standard"
      error = "ELEVENLABS_API_KEY environment variable is required"
    }

    // Validate text is not empty
    precondition ($input.text != null && $input.text != "") {
      error_type = "inputerror"
      error = "Text is required for speech generation"
    }

    // Build the request payload for ElevenLabs
    var $payload {
      value = {
        text: $input.text,
        model_id: $input.model_id,
        voice_settings: {
          stability: $input.stability,
          similarity_boost: $input.similarity_boost
        }
      }
    }

    // Make the API request to ElevenLabs
    // Note: ElevenLabs returns binary audio data (MP3)
    api.request {
      url = "https://api.elevenlabs.io/v1/text-to-speech/" ~ $input.voice_id
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "xi-api-key: " ~ $env.ELEVENLABS_API_KEY,
        "Accept: audio/mpeg"
      ]
      timeout = 60
    } as $api_result

    // Handle the response
    conditional {
      if ($api_result.response.status == 200) {
        // The audio data is in $api_result.response.result as base64
        // Build success response with audio data info
        var $api_response {
          value = {
            success: true,
            message: "Speech generated successfully",
            voice_id: $input.voice_id,
            model_id: $input.model_id,
            text_length: ($input.text|strlen),
            audio_format: "mp3",
            audio_data: $api_result.response.result,
            voice_settings: {
              stability: $input.stability,
              similarity_boost: $input.similarity_boost
            },
            created_at: now
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid or missing ElevenLabs API key"
        }
      }
      elseif ($api_result.response.status == 422) {
        throw {
          name = "ValidationError"
          value = "Invalid request parameters: " ~ ($api_result.response.result|json_encode)
        }
      }
      else {
        throw {
          name = "APIError"
          value = "ElevenLabs API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $api_response
}