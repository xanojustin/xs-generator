function "transcribe_audio" {
  description = "Transcribe audio file using Deepgram API"
  input {
    text audio_url { description = "URL to the audio file to transcribe" }
    text language { description = "Language code (e.g., en, es, fr)" }
    text model { description = "Deepgram model to use (e.g., nova-2, whisper)" }
  }
  stack {
    // Build the Deepgram API URL with query parameters
    var $api_url {
      value = "https://api.deepgram.com/v1/listen?model=" ~ $input.model ~ "&language=" ~ $input.language ~ "&punctuate=true&diarize=true&smart_format=true"
    }

    // Make request to Deepgram API
    api.request {
      url = $api_url
      method = "POST"
      headers = [
        "Authorization: Token " ~ $env.deepgram_api_key,
        "Content-Type: application/json"
      ]
      params = {
        url: $input.audio_url
      }
      timeout = 120
    } as $api_result

    // Check for successful response
    precondition ($api_result.response.status == 200) {
      error_type = "standard"
      error = "Deepgram API error: " ~ ($api_result.response.result|json_encode)
    }

    // Extract transcription results
    var $response_data { value = $api_result.response.result }
    var $transcript { value = $response_data.results.channels[0].alternatives[0].transcript }
    var $confidence { value = $response_data.results.channels[0].alternatives[0].confidence }
    var $words { value = $response_data.results.channels[0].alternatives[0].words }
    var $duration { value = $response_data.metadata.duration }
  }
  response = {
    transcript: $transcript,
    confidence: $confidence,
    word_count: $words|count,
    duration_seconds: $duration,
    model_used: $input.model,
    language: $input.language
  }
}
