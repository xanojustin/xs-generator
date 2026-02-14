# Zoom Create Meeting Run Job

This Xano Run Job creates a Zoom meeting using the Zoom Server-to-Server OAuth API.

## What It Does

Creates a new Zoom meeting with configurable topic, duration, and optional start time. Returns meeting details including join URL and host start URL.

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `zoom_account_id` | Your Zoom account ID | Zoom App Marketplace → Server-to-Server OAuth app → Credentials |
| `zoom_client_id` | OAuth app client ID | Zoom App Marketplace → Server-to-Server OAuth app → Credentials |
| `zoom_client_secret` | OAuth app client secret | Zoom App Marketplace → Server-to-Server OAuth app → Credentials |

## Setup Instructions

1. Go to [Zoom App Marketplace](https://marketplace.zoom.us/)
2. Create a new **Server-to-Server OAuth** app
3. Enable the `meeting:write:admin` scope
4. Copy the Account ID, Client ID, and Client Secret
5. Set these as environment variables in your Xano workspace

## Usage

### Basic Usage (Instant Meeting)

```bash
xano run execute --job=zoom-create-meeting
```

### With Custom Parameters

```json
{
  "topic": "Team Standup",
  "duration": 60,
  "start_time": "2025-02-15T10:00:00Z"
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `topic` | text | Yes | Meeting topic/title |
| `duration` | int | Yes | Meeting duration in minutes |
| `start_time` | text | No | Start time in ISO 8601 format (e.g., `2025-02-15T10:00:00Z`). If not provided, creates an instant meeting. |

## Response

```json
{
  "id": "1234567890",
  "topic": "Team Standup",
  "join_url": "https://zoom.us/j/1234567890?pwd=...",
  "start_url": "https://zoom.us/s/1234567890?...",
  "duration": 60,
  "created_at": "2025-02-13T21:45:00Z"
}
```

## File Structure

```
zoom-create-meeting/
├── run.xs                           # Run job configuration
├── function/
│   └── create_zoom_meeting.xs       # Main function implementation
└── README.md                        # This file
```
