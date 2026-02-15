run.job "Deepgram Transcribe Audio" {
  main = {
    name: "transcribe_audio"
    input: {
      audio_url: "https://example.com/audio.mp3"
      language: "en"
      model: "nova-2"
    }
  }
  env = ["deepgram_api_key"]
}
