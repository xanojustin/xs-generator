# Resend Digest - Xano Scheduled Task

## Overview

A Xano scheduled task that sends daily digest emails to users with pending notifications via the Resend API.

## What It Does

1. Runs every 30 minutes on a schedule
2. Queries the database for users who have digest notifications enabled
3. For each user, fetches unsent notifications from the last 30 minutes
4. If there are new notifications, compiles them into a digest email
5. Sends the digest via Resend API
6. Marks notifications as sent upon successful email delivery

## Files

| File | Purpose |
|------|---------|
| `send_pending_digest.xs` | Scheduled task configuration and logic |

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `RESEND_API_KEY` | Your Resend API key (re_...) |

## Database Schema Assumptions

This task expects the following tables:

### `user` table
- `id` - User identifier
- `email` - User's email address
- `name` - User's display name
- `digest_enabled` - Boolean flag to enable/disable digests

### `notification` table
- `id` - Notification identifier
- `user_id` - Reference to the user
- `message` - Notification message content
- `sent` - Boolean indicating if notification was sent in a digest
- `sent_at` - Timestamp when the digest was sent
- `created_at` - Timestamp when the notification was created

## Schedule

- **Frequency**: Every 30 minutes (1800 seconds)
- **Start Date**: 2026-02-12 18:00:00 UTC

## How to Set Up

1. Sign up for Resend at https://resend.com
2. Create an API key and add it to your Xano environment variables as `RESEND_API_KEY`
3. Ensure your `user` and `notification` tables exist with the required schema
4. Deploy the task to Xano

## Email Format

The digest email includes:
- Personalized greeting with the user's name
- Count of new notifications
- List of notification messages
- Automated footer

**From**: notifications@example.com  
**Subject**: "You have X new notification(s)"

## Response Handling

- **Success (200)**: Notifications are marked as sent with timestamp
- **Failure**: Error is logged but notifications remain unsent for retry

## Extending This Task

You could extend this to:
- Use HTML email templates instead of plain text
- Add different digest frequencies (daily, weekly)
- Group notifications by type/category
- Add unsubscribe links
- Track email opens and clicks
