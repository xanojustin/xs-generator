function "post_message" {
  description = "Post a message to a Slack channel"
  input {
    text channel filters=trim { description = "Slack channel ID or name (e.g., #general or C1234567890)" }
    text message filters=trim { description = "The message text to post" }
    text username?="Xano Bot" filters=trim { description = "Username to display as the sender" }
    text icon_emoji?=":robot_face:" filters=trim { description = "Emoji to use as the bot icon" }
  }
  stack {
    var $payload {
      value = {
        channel: $input.channel,
        text: $input.message,
        username: $input.username,
        icon_emoji: $input.icon_emoji
      }
    }

    api.request {
      url = "https://slack.com/api/chat.postMessage"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.SLACK_BOT_TOKEN
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300 && $api_result.response.result.ok == true) {
        var $slack_response { value = $api_result.response.result }

        db.add message_log {
          data = {
            channel: $input.channel,
            message: $input.message,
            username: $input.username,
            slack_timestamp: $slack_response.ts,
            slack_channel_id: $slack_response.channel,
            status: "sent",
            created_at: now
          }
        } as $log_entry

        var $result {
          value = {
            success: true,
            slack_timestamp: $slack_response.ts,
            slack_channel_id: $slack_response.channel,
            log_id: $log_entry.id
          }
        }
      }
      else {
        var $error_message {
          value = "Slack API error: " ~ ($api_result.response.result.error|to_text)
        }

        db.add message_log {
          data = {
            channel: $input.channel,
            message: $input.message,
            username: $input.username,
            status: "failed",
            error_message: $error_message,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "SlackError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}
