# AssemblyAI Transcribe Audio

A Xano Run Job that submits audio files for transcription using the AssemblyAI API.

## What This Run Job Does

This run job takes an audio file URL and submits it to AssemblyAI for speech-to-text transcription. It:
- Submits the audio file for transcription
- Returns a transcript ID for tracking
- Supports speaker diarization (who spoke when)
- Supports language specification

**Note:** This job submits the transcription and returns immediately with a transcript ID. You can use this ID to check the transcription status via the AssemblyAI API.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `ASSEMBLYAI_API_KEY` | Your AssemblyAI API key |

Get your API key at: https://www.assemblyai.com/

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `audio_url` | text | Yes | URL to the audio file to transcribe |
| `language_code` | text | No | Language code (e.g., "en_us", "es", "fr") |
| `speaker_labels` | bool | No | Enable speaker diarization (default: false) |

## Usage

### Basic Transcription

```json
{
  "audio_url": "https://example.com/audio.mp3"
}
```

### With Speaker Labels

```json
{
  "audio_url": "https://example.com/audio.mp3",
  "speaker_labels": true
}
```

### With Language Detection

```json
{
  "audio_url": "https://example.com/audio.mp3",
  "language_code": "en_us"
}
```

## Response

```json
{
  "transcript_id": "transcript_abc123",
  "status": "queued",
  "audio_url": "https://example.com/audio.mp3",
  "message": "Transcription submitted successfully. Use the transcript_id to check status."
}
```

## Checking Transcription Status

After submitting, you can check the status using the AssemblyAI API:

```bash
curl https://api.assemblyai.com/v2/transcript/{transcript_id} \
  -H "Authorization: YOUR_API_KEY"
```

## Supported Audio Formats

AssemblyAI supports:
- MP3, WAV, M4A, FLAC, OGG, WebM
- Maximum file size: 2GB (for URL-based uploads)

## Folder Structure

```
assemblyai-transcribe-audio/
├── run.xs                        # Run job configuration
├── function/
│   └── transcribe_audio.xs       # Transcription function
├── README.md                     # This file
└── FEEDBACK.md                   # Development feedback
```

## Notes

- Transcription time depends on audio length (typically 15-30% of audio duration)
- The job returns immediately after submission - it does not wait for completion
- Use the returned `transcript_id` to poll for results via the AssemblyAI API
- Speaker labels require the `speaker_labels` parameter set to `true`
