function "transcribe_audio" {
  input {
    text audio_url
    text language_code?="en"
    bool speaker_labels?=false
    bool punctuate?=true
    bool format_text?=true
  }

  stack {
    // Submit transcription request to AssemblyAI
    api.request {
      url = "https://api.assemblyai.com/v2/transcript"
      method = "POST"
      params = {
        audio_url: $input.audio_url,
        language_code: $input.language_code,
        speaker_labels: $input.speaker_labels,
        punctuate: $input.punctuate,
        format_text: $input.format_text
      }
      headers = [
        "Content-Type: application/json",
        "Authorization: " ~ $env.ASSEMBLYAI_API_KEY
      ]
      timeout = 30
    } as $submit_result

    // Check if submission was successful
    precondition ($submit_result.response.status == 200) {
      error_type = "standard"
      error = "Failed to submit transcription: " ~ ($submit_result.response.result|json_encode)
    }

    // Extract transcript ID
    var $transcript_id { value = $submit_result.response.result.id }

    // Poll for transcription completion (max 60 attempts, 2 second delay)
    var $attempts { value = 0 }
    var $max_attempts { value = 60 }
    var $transcription_complete { value = false }
    var $transcription_result { value = {} }

    while ($attempts < $max_attempts) {
      each {
        // Wait 2 seconds between polls
        util.sleep { value = 2 }

        // Check transcription status
        api.request {
          url = "https://api.assemblyai.com/v2/transcript/" ~ $transcript_id
          method = "GET"
          headers = [
            "Authorization: " ~ $env.ASSEMBLYAI_API_KEY
          ]
          timeout = 30
        } as $status_result

        var $status_code { value = $status_result.response.status }

        conditional {
          if ($status_code == 200) {
            var $transcript_status { value = $status_result.response.result.status }

            conditional {
              if ($transcript_status == "completed") {
                var.update $transcription_complete { value = true }
                var.update $transcription_result { value = $status_result.response.result }
              }
              elseif ($transcript_status == "error") {
                throw {
                  name = "TranscriptionError"
                  value = "Transcription failed: " ~ ($status_result.response.result.error ?? "Unknown error")
                }
              }
            }
          }
        }

        var.update $attempts { value = $attempts + 1 }
      }
    }

    // Check if we timed out
    precondition ($transcription_complete == true) {
      error_type = "standard"
      error = "Transcription timed out after " ~ ($max_attempts|to_text) ~ " attempts"
    }
  }

  response = {
    transcript_id: $transcription_result.id,
    text: $transcription_result.text,
    language_code: $transcription_result.language_code,
    status: $transcription_result.status,
    audio_duration: $transcription_result.audio_duration,
    confidence: $transcription_result.confidence,
    words: $transcription_result.words ?? [],
    utterances: $transcription_result.utterances ?? []
  }
}
