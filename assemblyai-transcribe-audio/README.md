# AssemblyAI Audio Transcription Run Job

A Xano Run Job that transcribes audio files using the AssemblyAI API.

## What It Does

This run job submits an audio file URL to AssemblyAI for transcription and polls until the transcription is complete. It supports:

- **Audio Transcription** - Converts speech to text from any audio file URL
- **Speaker Diarization** - Identifies different speakers (optional)
- **Automatic Punctuation** - Adds punctuation to transcriptions (enabled by default)
- **Text Formatting** - Automatically formats text (enabled by default)
- **Multi-language Support** - Specify language code (default: English/en)

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `ASSEMBLYAI_API_KEY` | Your AssemblyAI API key from https://www.assemblyai.com/ |

## How to Use

### Basic Usage

```bash
# Set your API key
export ASSEMBLYAI_API_KEY="your-api-key-here"

# Run the job
xano run
```

### Custom Input Parameters

Edit the `run.xs` file to customize the transcription:

```xs
run.job "AssemblyAI Transcribe Audio" {
  main = {
    name: "transcribe_audio"
    input: {
      audio_url: "https://your-domain.com/podcast-episode.mp3"
      language_code: "es"        // Spanish
      speaker_labels: true       // Identify speakers
      punctuate: true            // Add punctuation
      format_text: true          // Format text
    }
  }
  env = ["ASSEMBLYAI_API_KEY"]
}
```

### Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `audio_url` | text | Yes | - | URL to the audio file to transcribe |
| `language_code` | text | No | "en" | Language code (e.g., "en", "es", "fr", "de") |
| `speaker_labels` | bool | No | false | Enable speaker diarization |
| `punctuate` | bool | No | true | Add automatic punctuation |
| `format_text` | bool | No | true | Apply text formatting |

### Response

The job returns a JSON object with:

```json
{
  "transcript_id": "transcript-uuid",
  "text": "Full transcription text here...",
  "language_code": "en",
  "status": "completed",
  "audio_duration": 120.5,
  "confidence": 0.95,
  "words": [
    {
      "text": "Hello",
      "start": 0,
      "end": 500,
      "confidence": 0.98
    }
  ],
  "utterances": [
    {
      "speaker": "A",
      "text": "Speaker A's words...",
      "start": 0,
      "end": 5000
    }
  ]
}
```

## Supported Audio Formats

AssemblyAI supports most common audio formats:
- MP3
- WAV
- M4A
- FLAC
- OGG
- And more...

## API Reference

- [AssemblyAI Documentation](https://www.assemblyai.com/docs/)
- [Transcription API](https://www.assemblyai.com/docs/api-reference/transcripts/submit)

## File Structure

```
assemblyai-transcribe-audio/
├── run.xs                    # Job configuration
├── function/
│   └── transcribe_audio.xs   # Main transcription logic
└── README.md                 # This file
```

## Notes

- The job polls AssemblyAI every 2 seconds for up to 2 minutes (60 attempts)
- Transcription time depends on audio length and AssemblyAI's queue
- The `audio_url` must be publicly accessible
- For large files or longer processing times, increase the timeout or max_attempts in the function
