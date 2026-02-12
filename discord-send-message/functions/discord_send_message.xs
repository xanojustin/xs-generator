function "discord_send_message" {
  description = "Send a message to a Discord channel using a webhook"
  input {
    text webhook_url filters=trim
    text content filters=trim
    text username? filters=trim
    text avatar_url? filters=trim
    text embeds? filters=trim
  }
  stack {
    precondition (($input.webhook_url|is_empty) == false) {
      error_type = "inputerror"
      error = "Discord webhook URL is required"
    }

    precondition (($input.content|is_empty) == false) {
      error_type = "inputerror"
      error = "Message content is required"
    }

    var $payload {
      value = {
        content: $input.content
      }
    }

    conditional {
      if (($input.username|is_empty) == false) {
        var $payload {
          value = $payload|set:"username":$input.username
        }
      }
    }

    conditional {
      if (($input.avatar_url|is_empty) == false) {
        var $payload {
          value = $payload|set:"avatar_url":$input.avatar_url
        }
      }
    }

    conditional {
      if (($input.embeds|is_empty) == false) {
        var $embeds_array {
          value = $input.embeds|json_decode
        }
        var $payload {
          value = $payload|set:"embeds":$embeds_array
        }
      }
    }

    api.request {
      url = $input.webhook_url
      method = "POST"
      headers = [
        "Content-Type: application/json"
      ]
      params = $payload|json_encode
    } as $discord_response

    var $response_status {
      value = $discord_response.response.status
    }

    precondition ($response_status == 200 || $response_status == 204) {
      error_type = "standard"
      error = "Discord API error: HTTP " ~ $response_status ~ " - " ~ ($discord_response.response.body.message ?? "Unknown error")
    }

    var $response_body {
      value = $discord_response.response.body
    }
  }
  response = {
    success: true,
    status: $response_status,
    message_id: $response_body.id ?? null,
    channel_id: $response_body.channel_id ?? null,
    content_sent: $input.content|slice:0:100
  }
}
