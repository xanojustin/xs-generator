function "generate_tts" {
  description = "Generate text-to-speech audio using ElevenLabs API"
  input {
    text content { 
      description = "The text to convert to speech"
    }
    text voice_id?="21m00Tcm4TlvDq8ikWAM" {
      description = "ElevenLabs voice ID (default: Rachel)"
    }
    text model_id?="eleven_monolingual_v1" {
      description = "Model ID to use (default: eleven_monolingual_v1)"
    }
  }
  stack {
    // Validate input text is not empty
    precondition ($input.content != "") {
      error_type = "standard"
      error = "Text content is required for TTS generation"
    }

    // Prepare the request payload
    var $payload {
      value = {
        text: $input.content,
        model_id: $input.model_id,
        voice_settings: {
          stability: 0.5,
          similarity_boost: 0.5
        }
      }
    }

    // Call ElevenLabs API to generate speech
    api.request {
      url = "https://api.elevenlabs.io/v1/text-to-speech/" ~ $input.voice_id
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "xi-api-key: " ~ $env.ELEVENLABS_API_KEY
      ]
    } as $tts_response

    // Check for successful response
    precondition ($tts_response.response.status == 200) {
      error_type = "standard"
      error = "ElevenLabs API request failed: " ~ ($tts_response.response.status|to_text)
    }

    // Extract the audio data (binary content)
    var $audio_data {
      value = $tts_response.response.result
    }

    // Create response object with metadata
    var $result {
      value = {
        success: true,
        voice_id: $input.voice_id,
        model_id: $input.model_id,
        text_length: $input.content|count,
        audio_generated: true,
        content_type: "audio/mpeg"
      }
    }
  }
  response = $result
}
