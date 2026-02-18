run.job "ElevenLabs Generate Speech" {
  main = {
    name: "elevenlabs_generate_speech"
    input: {
      text: "Hello, this is a test of the ElevenLabs text to speech API. It sounds amazingly natural and human-like!"
      voice_id: "21m00Tcm4TlvDq8ikWAM"
      model_id: "eleven_monolingual_v1"
      stability: 0.5
      similarity_boost: 0.75
    }
  }
  env = ["ELEVENLABS_API_KEY"]
}