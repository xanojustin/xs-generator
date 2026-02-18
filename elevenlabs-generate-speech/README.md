# ElevenLabs Generate Speech Run Job

A Xano Run Job that converts text into natural-sounding speech using the ElevenLabs API.

## What It Does

This run job generates high-quality speech audio from text using ElevenLabs' state-of-the-art text-to-speech API. It demonstrates:
- External API integration with ElevenLabs
- Binary audio data handling (MP3 format)
- Error handling for authentication and validation errors
- Configurable voice settings (stability, similarity boost)
- Environment variable usage for API keys

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `ELEVENLABS_API_KEY` | Your ElevenLabs API key from https://elevenlabs.io/app/settings/api-keys | Yes |

## Usage

### Default Run
```bash
# Set your ElevenLabs API key
export ELEVENLABS_API_KEY="your_api_key_here"

# Run the job
xano job run elevenlabs-generate-speech/
```

### Customizing the Voice

Edit the `input` block in `run.xs`:

```xs
run.job "ElevenLabs Generate Speech" {
  main = {
    name: "elevenlabs_generate_speech"
    input: {
      text: "Your custom text here to convert to speech"
      voice_id: "21m00Tcm4TlvDq8ikWAM"
      model_id: "eleven_monolingual_v1"
      stability: 0.5
      similarity_boost: 0.75
    }
  }
  env = ["ELEVENLABS_API_KEY"]
}
```

### Available Voice IDs

Some popular ElevenLabs voice IDs:
- `21m00Tcm4TlvDq8ikWAM` - Rachel (default, female, American)
- `AZnzlk1XvdvUeBnXmlld` - Domi (male)
- `EXAVITQu4vr4xnSDxMaL` - Bella (female)
- `ErXwobaYiN019PkySvjV` - Antoni (male)
- `MF3mGyEYCl7XYWbV9V6O` - Elli (female)

Find more voices at: https://elevenlabs.io/app/voice-library

### Available Models

| Model | Description |
|-------|-------------|
| `eleven_monolingual_v1` | Default model for English |
| `eleven_multilingual_v2` | Best multilingual model |
| `eleven_turbo_v2` | Low-latency model |

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `text` | text | (required) | The text to convert to speech |
| `voice_id` | text | 21m00Tcm4TlvDq8ikWAM | Voice ID to use |
| `model_id` | text | eleven_monolingual_v1 | Model to use for generation |
| `stability` | decimal | 0.5 | Voice stability (0.0-1.0) |
| `similarity_boost` | decimal | 0.75 | Clarity/similarity boost (0.0-1.0) |

### Voice Settings Explained

- **Stability**: Higher values make the voice more consistent and less variable. Lower values allow more emotional range.
- **Similarity Boost**: Higher values make the voice clearer and more similar to the original voice. Lower values can add some variety.

## Output

The function returns a JSON object:

```json
{
  "success": true,
  "message": "Speech generated successfully",
  "voice_id": "21m00Tcm4TlvDq8ikWAM",
  "model_id": "eleven_monolingual_v1",
  "text_length": 89,
  "audio_format": "mp3",
  "audio_data": "//9j/4AAQ... (base64 encoded MP3)",
  "voice_settings": {
    "stability": 0.5,
    "similarity_boost": 0.75
  },
  "created_at": "2025-02-18T10:15:00Z"
}
```

The `audio_data` field contains the base64-encoded MP3 audio file.

## Error Handling

The job handles common error cases:
- **401** - Invalid or missing API key
- **422** - Invalid request parameters (bad voice ID, etc.)
- **Other errors** - Returns detailed error message

## Files

| File | Purpose |
|------|---------|
| `run.xs` | Run job configuration |
| `function/elevenlabs_generate_speech.xs` | Main function that calls ElevenLabs API |
| `README.md` | This documentation |
| `FEEDBACK.md` | MCP/XanoScript feedback for improvements |

## API Reference

- [ElevenLabs Text-to-Speech API](https://elevenlabs.io/docs/api-reference/text-to-speech)
- [ElevenLabs Voice Library](https://elevenlabs.io/voice-library)
- [XanoScript Functions](https://docs.xano.com/xanoscript/functions)
- [Xano Run Jobs](https://docs.xano.com/xanoscript/run)