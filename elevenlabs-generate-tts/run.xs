run.job "ElevenLabs TTS Generator" {
  main = {
    name: "generate_tts"
    input: {
      content: "Hello from Xano! This is a test of the ElevenLabs text-to-speech API."
      voice_id: "21m00Tcm4TlvDq8ikWAM"
      model_id: "eleven_monolingual_v1"
    }
  }
  env = ["ELEVENLABS_API_KEY"]
}
