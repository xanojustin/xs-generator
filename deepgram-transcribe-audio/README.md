# Deepgram Transcribe Audio

A Xano Run Job that transcribes audio files using the Deepgram voice AI API.

## What It Does

This run job takes an audio file URL and transcribes it to text using Deepgram's state-of-the-art speech recognition API. It supports multiple languages and models, and returns the full transcription along with metadata like confidence scores, word count, and audio duration.

## Features

- Transcribes audio from a URL
- Supports multiple languages (en, es, fr, de, etc.)
- Uses Deepgram's nova-2 model by default (high accuracy)
- Returns transcription with confidence scores
- Includes word-level timing and speaker diarization
- Smart formatting for punctuation and capitalization

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `deepgram_api_key` | Your Deepgram API key (get one at https://console.deepgram.com) |

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `audio_url` | text | Yes | - | URL to the audio file (mp3, wav, etc.) |
| `language` | text | No | en | Language code (e.g., en, es, fr) |
| `model` | text | No | nova-2 | Deepgram model (nova-2, whisper, etc.) |

## Response

```json
{
  "transcript": "Hello, this is a test transcription...",
  "confidence": 0.95,
  "word_count": 42,
  "duration_seconds": 15.3,
  "model_used": "nova-2",
  "language": "en"
}
```

## Usage

1. Set your `deepgram_api_key` environment variable in Xano
2. Run the job with your audio URL:

```xs
run.job "Deepgram Transcribe Audio" {
  main = {
    name: "transcribe_audio"
    input: {
      audio_url: "https://example.com/my-audio.mp3"
      language: "en"
      model: "nova-2"
    }
  }
  env = ["deepgram_api_key"]
}
```

## Supported Audio Formats

- MP3, MP4, MP2, MPGA, M4A
- WAV, FLAC
- OGG, WebM
- And more (see Deepgram docs)

## API Reference

- Deepgram API Docs: https://developers.deepgram.com/docs/pre-recorded-audio
