run.job "assemblyai_transcribe_audio" {
  main = {
    name: "transcribe_audio"
    input: {
      audio_url: "https://example.com/audio.mp3"
      language_code: "en_us"
      speaker_labels: false
    }
  }
  env = ["ASSEMBLYAI_API_KEY"]
}
