function "create_pagerduty_incident" {
  description = "Create an incident in PagerDuty using the Events API v2"
  input {
    text title filters=trim { description = "Incident title/summary" }
    text service_key filters=trim { description = "PagerDuty service integration key (routing key)" }
    text urgency?="high" filters=trim|lower { description = "Incident urgency: high or low" }
    text body?="" filters=trim { description = "Additional incident details" }
  }
  stack {
    var $payload {
      value = {
        routing_key: $input.service_key,
        event_action: "trigger",
        payload: {
          summary: $input.title,
          severity: $input.urgency,
          source: "Xano Run Job",
          custom_details: {
            details: $input.body
          }
        }
      }
    }

    api.request {
      url = "https://events.pagerduty.com/v2/enqueue"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status == 202) {
        var $incident { value = $api_result.response.result }

        db.add incident_log {
          data = {
            title: $input.title,
            service_key: $input.service_key,
            urgency: $input.urgency,
            body: $input.body,
            dedup_key: $incident.dedup_key,
            status: $incident.status,
            message: $incident.message,
            created_at: now
          }
        } as $log_entry

        var $result {
          value = {
            success: true,
            dedup_key: $incident.dedup_key,
            status: $incident.status,
            message: $incident.message,
            log_id: $log_entry.id
          }
        }
      }
      else {
        var $error_message {
          value = "PagerDuty API error: " ~ ($api_result.response.result.message|to_text)
        }

        db.add incident_log {
          data = {
            title: $input.title,
            service_key: $input.service_key,
            urgency: $input.urgency,
            body: $input.body,
            status: "failed",
            error_message: $error_message,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "PagerDutyError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}
