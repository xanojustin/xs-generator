# ElevenLabs Text-to-Speech Generator

A Xano Run Job that generates text-to-speech audio using the ElevenLabs API.

## What It Does

This run job converts text into natural-sounding speech using ElevenLabs' AI-powered text-to-speech API. It supports multiple voices and models for high-quality audio generation.

## Folder Structure

```
elevenlabs-generate-tts/
├── run.xs              # Run job configuration
├── function/
│   └── generate_tts.xs  # Function that calls ElevenLabs API
└── README.md           # This file
```

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `ELEVENLABS_API_KEY` | Your ElevenLabs API key (get from https://elevenlabs.io/app/settings/api-keys) |

## How to Use

### 1. Set up environment variables

Make sure `ELEVENLABS_API_KEY` is set in your Xano workspace environment variables.

### 2. Customize the input (optional)

Edit `run.xs` to change the default text, voice, or model:

```xs
run.job "ElevenLabs TTS Generator" {
  main = {
    name: "generate_tts"
    input: {
      content: "Your custom text here"
      voice_id: "21m00Tcm4TlvDq8ikWAM"  // Rachel voice
      model_id: "eleven_monolingual_v1"
    }
  }
  env = ["ELEVENLABS_API_KEY"]
}
```

### 3. Run the job

Execute the run job in Xano to generate speech from your text.

## Available Voices

Popular voice IDs from ElevenLabs:
- `21m00Tcm4TlvDq8ikWAM` - Rachel (default)
- `AZnzlk1XvdvUeBnXmlld` - Domi
- `EXAVITQu4vr4xnSDxMaL` - Bella
- `ErXwobaYiN019PkySvjV` - Antoni
- `MF3mGyEYCl7XYWbV9V6O` - Elli

## Response

The function returns a JSON object with:

```json
{
  "success": true,
  "voice_id": "21m00Tcm4TlvDq8ikWAM",
  "model_id": "eleven_monolingual_v1",
  "text_length": 42,
  "audio_generated": true,
  "content_type": "audio/mpeg"
}
```

## API Reference

- [ElevenLabs API Documentation](https://elevenlabs.io/docs/api-reference)
- [ElevenLabs Voices](https://elevenlabs.io/voice-library)
