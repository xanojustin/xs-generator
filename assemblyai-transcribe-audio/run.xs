run.job "AssemblyAI Transcribe Audio" {
  main = {
    name: "transcribe_audio"
    input: {
      audio_url: "https://example.com/audio.mp3"
      language_code: "en"
      speaker_labels: true
    }
  }
  env = ["ASSEMBLYAI_API_KEY"]
}
