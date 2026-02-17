function "track_event" {
  input {
    text event
    text distinct_id
    json properties?
  }
  stack {
    // Build the event data payload for Mixpanel
    var $event_data {
      value = {
        event: $input.event,
        properties: {
          distinct_id: $input.distinct_id,
          time: now|to_int,
          $insert_id: ($input.distinct_id ~ "_" ~ now|to_text)|md5
        }
      }
    }

    // Merge custom properties if provided
    conditional {
      if ($input.properties != null) {
        var $merged_props {
          value = $event_data.properties|merge:$input.properties
        }
        var.update $event_data {
          value = $event_data|set:"properties":$merged_props
        }
      }
    }

    // Prepare the request payload (Mixpanel expects an array of events)
    var $payload {
      value = [$event_data]
    }

    // Send the event to Mixpanel
    api.request {
      url = "https://api.mixpanel.com/import"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: " ~ $env.mixpanel_api_secret
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    conditional {
      if ($api_result.response.status == 200) {
        var $result { value = $api_result.response.result }
      }
      else {
        throw {
          name = "MixpanelAPIError"
          value = "Mixpanel API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = {
    success: true
    event: $input.event
    distinct_id: $input.distinct_id
    mixpanel_response: $result
  }
}
