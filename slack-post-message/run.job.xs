task "slack_post_message" {
  description = "Post a message to a Slack channel using the Slack Web API"
  
  stack {
    debug.log {
      value = "Starting Slack message post task"
      description = "Log task start"
    }

    var $slack_token {
      description = "Slack Bot User OAuth Token from environment"
      value = $env.slack_bot_token
    }

    precondition ($slack_token != "") {
      error_type = "inputerror"
      error = "Slack bot token is not configured. Please set slack_bot_token environment variable."
      description = "Ensure Slack bot token is configured"
    }

    var $channel {
      description = "Target Slack channel ID or name"
      value = $env.slack_channel_id
    }

    precondition ($channel != "") {
      error_type = "inputerror"
      error = "Slack channel is not configured. Please set slack_channel_id environment variable."
      description = "Ensure Slack channel is configured"
    }

    var $message_text {
      description = "Message content to post"
      value = $env.slack_message_text
    }

    precondition ($message_text != "") {
      error_type = "inputerror"
      error = "Message text is not configured. Please set slack_message_text environment variable."
      description = "Ensure message text is configured"
    }

    var $request_payload {
      description = "Build the Slack API request payload"
      value = {
        channel: $channel,
        text: $message_text,
        unfurl_links: true,
        unfurl_media: true
      }
    }

    api.request {
      description = "Send message to Slack via chat.postMessage API"
      url = "https://slack.com/api/chat.postMessage"
      method = "POST"
      params = $request_payload
      headers = []|push:"Authorization: Bearer " ~ $slack_token|push:"Content-Type: application/json; charset=utf-8"
      timeout = 30
    } as $slack_response

    var $response_body {
      description = "Extract response body"
      value = $slack_response.response.result
    }

    var $error_message {
      description = "Extract error message or use default"
      value = ($response_body.error != "") ? $response_body.error : "unknown error"
    }

    conditional {
      description = "Check if Slack API returned success"
      if ($response_body.ok == true) {
        debug.log {
          value = "Message posted successfully to channel: " ~ $response_body.channel
          description = "Log successful message post"
        }

        var $result {
          description = "Success result with message details"
          value = {
            success: true,
            channel: $response_body.channel,
            timestamp: $response_body.ts,
            message_text: $message_text,
            posted_at: now
          }
        }
      }

      else {
        debug.log {
          value = "Slack API error: " ~ $error_message
          description = "Log Slack API error"
        }

        throw {
          name = "SlackAPIError"
          value = "Slack API error: " ~ $error_message
        }
      }
    }

    debug.log {
      value = "Slack post message task completed successfully"
      description = "Log task completion"
    }
  }

  schedule = [{starts_on: 2026-02-12 16:00:00+0000, freq: 3600}]

  history = "inherit"
}
