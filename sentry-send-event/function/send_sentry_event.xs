function "send_sentry_event" {
  input {
    text message
    text level = "error"
    text environment = "production"
    text release?
    text user_id?
    text[] tags?
    object extra?
  }
  stack {
    // Parse DSN to extract components
    // DSN format: https://public_key@ingest.sentry.io/project_id
    
    var $dsn_parts {
      value = $env.SENTRY_DSN|split:"@"
    }
    
    precondition (($dsn_parts|count) == 2) {
      error_type = "standard"
      error = "Invalid SENTRY_DSN format"
    }
    
    // Extract public key from first part (after https://)
    var $first_part {
      value = $dsn_parts|first
    }
    
    var $key_parts {
      value = $first_part|split:"/"
    }
    
    var $public_key {
      value = $key_parts|last
    }
    
    // Extract host from second part (before /)
    var $second_part {
      value = $dsn_parts|last
    }
    
    var $host_parts {
      value = $second_part|split:"/"
    }
    
    var $host {
      value = $host_parts|first
    }
    
    var $project_id {
      value = $env.SENTRY_PROJECT_ID
    }
    
    // Build Sentry envelope
    security.create_uuid as $event_id
    
    // Current timestamp in ISO format
    var $timestamp {
      value = now|format_timestamp:"Y-m-d\\TH:i:s" ~ ".000Z"
    }
    
    // Build the event payload
    var $event_payload {
      value = {
        event_id: $event_id|replace:"-":"",
        timestamp: $timestamp,
        platform: "javascript",
        level: $input.level,
        environment: $input.environment,
        message: {
          formatted: $input.message
        }
      }
    }
    
    // Add optional release
    conditional {
      if ($input.release != null && $input.release != "") {
        var.update $event_payload {
          value = $event_payload|set:"release":$input.release
        }
      }
    }
    
    // Add user context if provided
    conditional {
      if ($input.user_id != null && $input.user_id != "") {
        var.update $event_payload {
          value = $event_payload|set:"user":{ id: $input.user_id }
        }
      }
    }
    
    // Add tags if provided
    conditional {
      if ($input.tags != null && ($input.tags|count) > 0) {
        var $tags_obj { value = {} }
        each ($input.tags as $tag) {
          var $tag_parts { value = $tag|split:":" }
          conditional {
            if (($tag_parts|count) >= 2) {
              var $tag_key { value = $tag_parts|first }
              var $tag_value { value = $tag_parts|last }
              var.update $tags_obj {
                value = $tags_obj|set:$tag_key:$tag_value
              }
            }
          }
        }
        var.update $event_payload {
          value = $event_payload|set:"tags":$tags_obj
        }
      }
    }
    
    // Add extra context if provided
    conditional {
      if ($input.extra != null) {
        var.update $event_payload {
          value = $event_payload|set:"extra":$input.extra
        }
      }
    }
    
    // Build envelope headers
    var $envelope_headers {
      value = {
        event_id: $event_id|replace:"-":"",
        dsn: $env.SENTRY_DSN
      }
    }
    
    // Build envelope item header
    var $item_header {
      value = {
        type: "event"
      }
    }
    
    // Construct full envelope
    var $envelope {
      value = ($envelope_headers|json_encode) ~ "\n" ~ ($item_header|json_encode) ~ "\n" ~ ($event_payload|json_encode)
    }
    
    // Send to Sentry
    api.request {
      url = "https://" ~ $host ~ "/api/" ~ $project_id ~ "/envelope/"
      method = "POST"
      params = $envelope
      headers = [
        "Content-Type: application/x-sentry-envelope",
        "X-Sentry-Auth: Sentry sentry_version=7, sentry_key=" ~ $public_key ~ ", sentry_client=xano-script/1.0"
      ]
      timeout = 30
    } as $sentry_response
    
    // Check response
    conditional {
      if ($sentry_response.response.status >= 200 && $sentry_response.response.status < 300) {
        var $result {
          value = {
            success: true,
            event_id: $event_id,
            status: $sentry_response.response.status
          }
        }
      }
      else {
        var $result {
          value = {
            success: false,
            error: "Sentry API error: " ~ ($sentry_response.response.status|to_text),
            response: $sentry_response.response.result
          }
        }
      }
    }
  }
  response = $result
}
