function "send_discord_webhook" {
  input {
    text content
    text username
    text avatar_url
    text title
    text description
    text color
    text footer_text
  }
  stack {
    // Validate required webhook URL
    precondition ($env.discord_webhook_url != null && $env.discord_webhook_url != "") {
      error_type = "standard"
      error = "discord_webhook_url environment variable is required"
    }

    // Build the embed object if any embed fields are provided
    var $has_title {
      value = ($input.title != null && $input.title != "")
    }
    var $has_description {
      value = ($input.description != null && $input.description != "")
    }
    var $has_embed {
      value = $has_title || $has_description
    }

    // Construct the payload
    var $payload {
      value = {}
    }

    // Add content if provided
    conditional {
      if ($input.content != null && $input.content != "") {
        var.update $payload {
          value = $payload ~ {content: $input.content}
        }
      }
    }

    // Add username override if provided
    conditional {
      if ($input.username != null && $input.username != "") {
        var.update $payload {
          value = $payload ~ {username: $input.username}
        }
      }
    }

    // Add avatar_url override if provided
    conditional {
      if ($input.avatar_url != null && $input.avatar_url != "") {
        var.update $payload {
          value = $payload ~ {avatar_url: $input.avatar_url}
        }
      }
    }

    // Build embed if fields provided
    conditional {
      if ($has_embed) {
        var $embed {
          value = {}
        }

        // Add title to embed
        conditional {
          if ($input.title != null && $input.title != "") {
            var.update $embed {
              value = $embed ~ {title: $input.title}
            }
          }
        }

        // Add description to embed
        conditional {
          if ($input.description != null && $input.description != "") {
            var.update $embed {
              value = $embed ~ {description: $input.description}
            }
          }
        }

        // Add color to embed (default to Xano blue)
        var $embed_color {
          value = 3447003
        }
        conditional {
          if ($input.color != null && $input.color != "") {
            var.update $embed_color {
              value = $input.color|to_int
            }
          }
        }
        var.update $embed {
          value = $embed ~ {color: $embed_color}
        }

        // Add footer if provided
        conditional {
          if ($input.footer_text != null && $input.footer_text != "") {
            var.update $embed {
              value = $embed ~ {footer: {text: $input.footer_text}}
            }
          }
        }

        // Add timestamp
        var $timestamp {
          value = "now"|to_timestamp|format_timestamp:"Y-m-d\TH:i:s.vP":"UTC"
        }
        var.update $embed {
          value = $embed ~ {timestamp: $timestamp}
        }

        // Add embed to payload
        var.update $payload {
          value = $payload ~ {embeds: [$embed]}
        }
      }
    }

    // Validate that we have either content or embeds
    precondition ($payload.content != null || $payload.embeds != null) {
      error_type = "inputerror"
      error = "Either content or title/description must be provided"
    }

    // Make the webhook request to Discord
    api.request {
      url = $env.discord_webhook_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $discord_response

    // Check response status
    conditional {
      if ($discord_response.response.status >= 200 && $discord_response.response.status < 300) {
        var $result {
          value = {
            success: true,
            status: $discord_response.response.status,
            message: "Message sent successfully to Discord"
          }
        }
      }
      else {
        var $error_message {
          value = "Discord API error: " ~ ($discord_response.response.status|to_text)
        }
        conditional {
          if ($discord_response.response.result.message != null) {
            var.update $error_message {
              value = $error_message ~ " - " ~ $discord_response.response.result.message
            }
          }
        }
        throw {
          name = "DiscordError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}