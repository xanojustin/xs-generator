function "transcribe_audio" {
  input {
    text audio_url
    text language_code?
    bool speaker_labels?=false
  }
  stack {
    // Validate required inputs
    precondition ($input.audio_url != null && $input.audio_url != "") {
      error_type = "inputerror"
      error = "audio_url is required"
    }

    // Build the request payload
    var $payload { 
      value = { 
        audio_url: $input.audio_url,
        speaker_labels: $input.speaker_labels
      } 
    }

    // Add optional language code if provided
    conditional {
      if ($input.language_code != null) {
        var.update $payload { 
          value = $payload|set:"language_code":$input.language_code 
        }
      }
    }

    // Submit transcription request to AssemblyAI
    api.request {
      url = "https://api.assemblyai.com/v2/transcript"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: " ~ $env.ASSEMBLYAI_API_KEY
      ]
      timeout = 30
    } as $submit_result

    // Check if submission was successful
    conditional {
      if ($submit_result.response.status == 200) {
        var $transcript_id { value = $submit_result.response.result.id }
        var $status { value = $submit_result.response.result.status }
        
        var $result {
          value = {
            transcript_id: $transcript_id,
            status: $status,
            audio_url: $input.audio_url,
            message: "Transcription submitted successfully. Use the transcript_id to check status."
          }
        }
      }
      else {
        throw {
          name = "APIError"
          value = "Failed to submit transcription: " ~ ($submit_result.response.status|to_text)
        }
      }
    }
  }
  response = $result
}
