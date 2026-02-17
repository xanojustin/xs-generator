function "sentry_create_issue" {
  description = "Create an issue/event in Sentry for error tracking"
  input {
    text message { description = "Error message or issue title" }
    text level?="error" { 
      description = "Severity level: fatal, error, warning, info, debug"
    }
    text environment?="production" { 
      description = "Environment name: production, staging, development"
    }
    text platform?="javascript" { 
      description = "Platform identifier: javascript, python, node, php, etc."
    }
    object tags? { 
      description = "Key-value pairs for event tags"
    }
    object extra? { 
      description = "Additional context data for the event"
    }
  }
  stack {
    // Parse the DSN to extract components
    // Format: https://public_key@host/project_id
    var $dsn_parts {
      value = $env.sentry_dsn|split:"@"
    }
    
    var $auth_part {
      value = $dsn_parts|first
    }
    
    var $public_key {
      value = $auth_part|replace:"https://":""
    }
    
    var $remaining {
      value = $dsn_parts|last
    }
    
    var $host_project {
      value = $remaining|split:"/"
    }
    
    var $host {
      value = $host_project|first
    }
    
    var $project_id {
      value = $host_project|last
    }
    
    // Construct the store URL
    var $store_url {
      value = "https://" ~ $host ~ "/api/" ~ $project_id ~ "/store/"
    }
    
    // Build the Sentry event payload
    var $event_id {
      value = ""|uuid|replace:"-":""|to_lower
    }
    
    var $timestamp {
      value = "now"|to_timestamp|format_timestamp:"Y-m-d\\TH:i:s":"UTC"
    }
    
    var $payload {
      value = {
        event_id: $event_id,
        timestamp: $timestamp,
        platform: $input.platform,
        level: $input.level,
        environment: $input.environment,
        message: {
          formatted: $input.message
        },
        tags: $input.tags,
        extra: $input.extra
      }
    }
    
    // Generate Sentry authentication header
    // X-Sentry-Auth: Sentry sentry_version=7, sentry_client=xano-script/1.0, sentry_timestamp=<ts>, sentry_key=<key>
    var $sentry_timestamp {
      value = "now"|to_timestamp|to_seconds|to_text
    }
    
    var $sentry_auth {
      value = "Sentry sentry_version=7, sentry_client=xano-run/1.0, sentry_timestamp=" ~ $sentry_timestamp ~ ", sentry_key=" ~ $public_key
    }
    
    // Send event to Sentry
    api.request {
      url = $store_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "X-Sentry-Auth: " ~ $sentry_auth
      ]
      timeout = 30
    } as $api_result
    
    // Handle response
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $result {
          value = {
            success: true,
            event_id: $event_id,
            sentry_response: $api_result.response.result
          }
        }
      }
      else {
        throw {
          name = "SentryAPIError"
          value = "Sentry API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $result
}
