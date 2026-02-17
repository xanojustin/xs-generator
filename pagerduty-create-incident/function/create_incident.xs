function "create_incident" {
  description = "Create an incident in PagerDuty"
  input {
    text title { description = "The title/summary of the incident" }
    text description { description = "Detailed description of the incident" }
    text urgency?="high" { description = "Incident urgency: 'high' or 'low' (default: high)" }
    text service_id { description = "The PagerDuty service ID to associate with this incident" }
  }
  stack {
    var $payload {
      value = {
        incident: {
          type: "incident",
          title: $input.title,
          service: {
            id: $input.service_id,
            type: "service_reference"
          },
          urgency: $input.urgency,
          body: {
            type: "incident_body",
            details: $input.description
          }
        }
      }
    }

    api.request {
      url = "https://api.pagerduty.com/incidents"
      method = "POST"
      params = $payload
      headers = [
        "Authorization: Bearer " ~ $env.pagerduty_api_key,
        "Content-Type: application/json",
        "Accept: application/vnd.pagerduty+json;version=2"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $incident { value = $api_result.response.result }
      }
      else {
        throw {
          name = "PagerDutyAPIError"
          value = "PagerDuty API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $incident
}