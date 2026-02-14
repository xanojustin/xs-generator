function "trigger_incident" {
  description = "Trigger a PagerDuty incident via the Events API v2"
  input {
    text summary
    text severity="critical"
    text source?="Xano Run Job"
    text component?=""
    text group?=""
    text class?=""
  }
  stack {
    // Build the PagerDuty payload
    var $payload {
      value = {
        routing_key: $env.pagerduty_integration_key,
        event_action: "trigger",
        payload: {
          summary: $input.summary,
          severity: $input.severity,
          source: $input.source,
          component: $input.component,
          group: $input.group,
          class: $input.class,
          timestamp: now|format_timestamp:"Y-m-d\\TH:i:s.u\\Z":"UTC"
        }
      }|set_ifnotnull:"component":$input.component
        |set_ifnotnull:"group":$input.group
        |set_ifnotnull:"class":$input.class
    }

    // Send request to PagerDuty Events API v2
    api.request {
      url = "https://events.pagerduty.com/v2/enqueue"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    conditional {
      if ($api_result.response.status == 202) {
        var $result {
          value = {
            success: true,
            message: "Incident triggered successfully",
            dedup_key: $api_result.response.result.dedup_key,
            status: $api_result.response.result.status
          }
        }
      }
      else {
        var $result {
          value = {
            success: false,
            message: "Failed to trigger incident",
            status: $api_result.response.status,
            error: $api_result.response.result|json_encode
          }
        }
      }
    }
  }
  response = $result
}
