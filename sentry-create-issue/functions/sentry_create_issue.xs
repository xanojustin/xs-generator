function "sentry_create_issue" {
  description = "Create a Sentry issue/event to track errors or messages in your application"
  
  input {
    text message filters=trim {
      description = "The main error message or event title"
    }
    
    text level?=error filters=trim {
      description = "Event level: fatal, error, warning, info, debug (default: error)"
    }
    
    text environment?=production filters=trim {
      description = "Environment name: production, staging, development (default: production)"
    }
    
    text release? filters=trim {
      description = "Release version (e.g., 1.0.0)"
    }
    
    text platform?=javascript filters=trim {
      description = "Platform/language: javascript, python, node, php, go, ruby, etc. (default: javascript)"
    }
    
    text culprit? filters=trim {
      description = "Culprit/function where error occurred"
    }
    
    json extra? {
      description = "Additional context data as JSON object"
    }
    
    json tags? {
      description = "Tags to attach to the event as JSON object"
    }
    
    json user? {
      description = "User context as JSON object with id, email, username, ip_address"
    }
    
    json exception? {
      description = "Exception details as JSON object with type, value, stacktrace"
    }
  }
  
  stack {
    precondition (($input.message|is_empty) == false) {
      description = "Validate message is not empty"
      error_type = "inputerror"
      error = "Message is required to create a Sentry issue"
    }
    
    var $valid_levels {
      description = "List of valid Sentry event levels"
      value = ["fatal", "error", "warning", "info", "debug"]
    }
    
    var $event_level {
      value = ($valid_levels|contains:$input.level) ? $input.level : "error"
    }
    
    security.create_uuid as $event_id
    
    var $timestamp {
      description = "Current timestamp in ISO 8601 format"
      value = now|date_format:"c"
    }
    
    var $event_payload {
      description = "Initialize base Sentry event payload"
      value = {
        event_id: $event_id|replace:"-":"",
        timestamp: $timestamp,
        platform: $input.platform,
        level: $event_level,
        environment: $input.environment,
        message: {
          formatted: $input.message
        },
        server_name: "xano-instance",
        logger: "xano.sentry",
        tags: {
          source: "xano-run-job"
        }
      }
    }
    
    conditional {
      description = "Add release if provided"
      if (($input.release|is_empty) == false) {
        var.update $event_payload {
          value = $event_payload|set:"release":$input.release
        }
      }
    }
    
    conditional {
      description = "Add culprit if provided"
      if (($input.culprit|is_empty) == false) {
        var.update $event_payload {
          value = $event_payload|set:"culprit":$input.culprit
        }
      }
    }
    
    conditional {
      description = "Add extra context if provided"
      if ($input.extra != null && ($input.extra|object.keys|count) > 0) {
        var.update $event_payload {
          value = $event_payload|set:"extra":$input.extra
        }
      }
    }
    
    conditional {
      description = "Add tags if provided"
      if ($input.tags != null && ($input.tags|object.keys|count) > 0) {
        var $merged_tags {
          value = $event_payload.tags|merge:$input.tags
        }
        var.update $event_payload {
          value = $event_payload|set:"tags":$merged_tags
        }
      }
    }
    
    conditional {
      description = "Add user context if provided"
      if ($input.user != null && ($input.user|object.keys|count) > 0) {
        var.update $event_payload {
          value = $event_payload|set:"user":$input.user
        }
      }
    }
    
    conditional {
      description = "Add exception details if provided"
      if ($input.exception != null && ($input.exception|object.keys|count) > 0) {
        var $exception_values {
          value = [$input.exception]
        }
        var.update $event_payload {
          value = $event_payload|set:"exception":{values: $exception_values}
        }
      }
    }
    
    var $sentry_auth_header {
      description = "Build Sentry authentication header"
      value = "Sentry sentry_version=7, sentry_key=" ~ $env.sentry_dsn_public_key ~ ", sentry_client=xano-script/1.0"
    }
    
    api.request {
      description = "Send event to Sentry API"
      url = $env.sentry_store_url
      method = "POST"
      params = $event_payload
      headers = []|push:"Content-Type: application/json"|push:"X-Sentry-Auth: " ~ $sentry_auth_header
      timeout = 30
    } as $sentry_response
    
    var $response_status {
      value = $sentry_response.response.status
    }
    
    var $response_body {
      value = $sentry_response.response.body
    }
  }
  
  response = {
    success: ($response_status >= 200) && ($response_status < 300),
    event_id: ($response_body|has:"id") ? $response_body.id : null,
    status_code: $response_status,
    message: ($response_status >= 200) && ($response_status < 300) ? "Event created successfully in Sentry" : "Failed to create Sentry event"
  }
}
