function "track_event" {
  input {
    text event_type filters=trim
    text user_id? filters=trim
    text device_id? filters=trim
    json event_properties?
    json user_properties?
    decimal time?
    text platform?
    text os_name?
    text os_version?
    text device_brand?
    text device_model?
    text carrier?
    text country?
    text region?
    text city?
    text dma?
    text language?
  }
  stack {
    precondition ($input.user_id != null || $input.device_id != null) {
      error_type = "inputerror"
      error = "Either user_id or device_id must be provided"
    }

    precondition ($input.event_type != null && $input.event_type != "") {
      error_type = "inputerror"
      error = "event_type is required"
    }

    var $event_payload {
      value = {
        event_type: $input.event_type
      }
    }

    conditional {
      if ($input.user_id != null && $input.user_id != "") {
        var.update $event_payload {
          value = $event_payload|set:"user_id":$input.user_id
        }
      }
    }

    conditional {
      if ($input.device_id != null && $input.device_id != "") {
        var.update $event_payload {
          value = $event_payload|set:"device_id":$input.device_id
        }
      }
    }

    conditional {
      if ($input.event_properties != null) {
        var.update $event_payload {
          value = $event_payload|set:"event_properties":$input.event_properties
        }
      }
    }

    conditional {
      if ($input.user_properties != null) {
        var.update $event_payload {
          value = $event_payload|set:"user_properties":$input.user_properties
        }
      }
    }

    conditional {
      if ($input.time != null) {
        var.update $event_payload {
          value = $event_payload|set:"time":($input.time|to_int)
        }
      }
    }

    conditional {
      if ($input.platform != null && $input.platform != "") {
        var.update $event_payload {
          value = $event_payload|set:"platform":$input.platform
        }
      }
    }

    conditional {
      if ($input.os_name != null && $input.os_name != "") {
        var.update $event_payload {
          value = $event_payload|set:"os_name":$input.os_name
        }
      }
    }

    conditional {
      if ($input.os_version != null && $input.os_version != "") {
        var.update $event_payload {
          value = $event_payload|set:"os_version":$input.os_version
        }
      }
    }

    conditional {
      if ($input.device_brand != null && $input.device_brand != "") {
        var.update $event_payload {
          value = $event_payload|set:"device_brand":$input.device_brand
        }
      }
    }

    conditional {
      if ($input.device_model != null && $input.device_model != "") {
        var.update $event_payload {
          value = $event_payload|set:"device_model":$input.device_model
        }
      }
    }

    conditional {
      if ($input.country != null && $input.country != "") {
        var.update $event_payload {
          value = $event_payload|set:"country":$input.country
        }
      }
    }

    conditional {
      if ($input.region != null && $input.region != "") {
        var.update $event_payload {
          value = $event_payload|set:"region":$input.region
        }
      }
    }

    conditional {
      if ($input.city != null && $input.city != "") {
        var.update $event_payload {
          value = $event_payload|set:"city":$input.city
        }
      }
    }

    conditional {
      if ($input.language != null && $input.language != "") {
        var.update $event_payload {
          value = $event_payload|set:"language":$input.language
        }
      }
    }

    var $api_payload {
      value = {
        api_key: $env.AMPLITUDE_API_KEY
        events: [$event_payload]
      }
    }

    api.request {
      url = "https://api2.amplitude.com/2/httpapi"
      method = "POST"
      params = $api_payload
      headers = [
        "Content-Type: application/json"
        "Accept: application/json"
      ]
      timeout = 30
    } as $amplitude_response

    conditional {
      if ($amplitude_response.response.status == 200) {
        var $result {
          value = {
            success: true
            message: "Event tracked successfully"
            event_type: $input.event_type
            code: $amplitude_response.response.result.code
          }
        }
      }
      elseif ($amplitude_response.response.status == 400) {
        throw {
          name = "AmplitudeError"
          value = "Bad request: " ~ ($amplitude_response.response.result|json_encode)
        }
      }
      elseif ($amplitude_response.response.status == 413) {
        throw {
          name = "AmplitudeError"
          value = "Request payload too large"
        }
      }
      elseif ($amplitude_response.response.status == 429) {
        throw {
          name = "AmplitudeError"
          value = "Rate limit exceeded"
        }
      }
      else {
        throw {
          name = "AmplitudeError"
          value = "API error (status " ~ ($amplitude_response.response.status|to_text) ~ "): " ~ ($amplitude_response.response.result|json_encode)
        }
      }
    }

    debug.log {
      value = "Amplitude event tracked: " ~ $input.event_type
    }
  }
  response = $result
}
