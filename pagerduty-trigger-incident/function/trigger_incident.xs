function "trigger_incident" {
  input {
    text routing_key
    text summary
    text severity?="critical"
    text source?="Xano Run Job"
    text component?
    text group?
    text class?
    json custom_details?
  }
  stack {
    precondition (($input.routing_key|is_empty) == false) {
      error_type = "inputerror"
      error = "routing_key is required - provide your PagerDuty Integration Key"
    }
    precondition (($input.summary|is_empty) == false) {
      error_type = "inputerror"
      error = "summary is required - describe the incident"
    }

    var $valid_severities { value = ["critical", "error", "warning", "info"] }
    precondition ($valid_severities|contains:$input.severity) {
      error_type = "inputerror"
      error = "severity must be one of: critical, error, warning, info"
    }

    security.create_uuid as $dedup_key

    var $payload { 
      value = {
        routing_key: $input.routing_key,
        event_action: "trigger",
        dedup_key: $dedup_key,
        payload: {
          summary: $input.summary,
          severity: $input.severity,
          source: $input.source,
          timestamp: now|format_timestamp:"Y-m-d\\TH:i:s.vP"
        }
      }
    }

    var $payload_with_extras { value = $payload.value }

    conditional {
      if (($input.component|is_empty) == false) {
        var $payload_with_extras { 
          value = $payload_with_extras.value|set:"payload":($payload_with_extras.value.payload|set:"component":$input.component)
        }
      }
    }

    conditional {
      if (($input.group|is_empty) == false) {
        var $payload_with_extras { 
          value = $payload_with_extras.value|set:"payload":($payload_with_extras.value.payload|set:"group":$input.group)
        }
      }
    }

    conditional {
      if (($input.class|is_empty) == false) {
        var $payload_with_extras { 
          value = $payload_with_extras.value|set:"payload":($payload_with_extras.value.payload|set:"class":$input.class)
        }
      }
    }

    conditional {
      if ($input.custom_details != null && ($input.custom_details|is_empty) == false) {
        var $payload_with_extras { 
          value = $payload_with_extras.value|set:"payload":($payload_with_extras.value.payload|set:"custom_details":$input.custom_details)
        }
      }
    }

    api.request {
      url = "https://events.pagerduty.com/v2/enqueue"
      method = "POST"
      params = $payload_with_extras.value|json_encode
      headers = ["Content-Type: application/json"]
      timeout = 30
    } as $api_result

    precondition ($api_result.response.status == 202) {
      error_type = "standard"
      error = "PagerDuty API error: " ~ ($api_result.response.result|json_decode|get:"message" ?? "Unknown error")
    }

    var $response_body { value = $api_result.response.result|json_decode }
  }
  response = {
    status: "incident_triggered",
    dedup_key: $dedup_key,
    incident_key: $response_body|get:"dedup_key",
    message: $response_body|get:"message",
    status_code: $api_result.response.status
  }
}
