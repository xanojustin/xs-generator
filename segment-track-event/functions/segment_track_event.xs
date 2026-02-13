function "segment_track_event" {
  description = "Track a custom event to Segment analytics"
  input {
    text user_id filters=trim {
      description = "Unique identifier for the user"
    }
    text event filters=trim {
      description = "The event name to track"
    }
    json properties? {
      description = "Optional event properties as JSON object"
    }
    json context? {
      description = "Optional context information"
    }
    timestamp timestamp? {
      description = "Optional timestamp for the event (defaults to now)"
    }
  }
  stack {
    precondition (($input.user_id|is_empty) == false) {
      error_type = "inputerror"
      error = "User ID is required"
    }

    precondition (($input.event|is_empty) == false) {
      error_type = "inputerror"
      error = "Event name is required"
    }

    var $event_properties {
      value = ($input.properties|is_empty) == false ? $input.properties : {}
    }

    var $event_context {
      value = ($input.context|is_empty) == false ? $input.context : {}
    }

    var $event_timestamp {
      value = ($input.timestamp|is_empty) == false ? $input.timestamp : now
    }

    var $iso_timestamp {
      value = $event_timestamp|format_timestamp:"Y-m-d\\TH:i:s\\Z":"UTC"
    }

    var $track_payload {
      value = {
        userId: $input.user_id,
        event: $input.event,
        properties: $event_properties,
        context: $event_context,
        timestamp: $iso_timestamp
      }
    }

    api.request {
      url = "https://api.segment.io/v1/track"
      method = "POST"
      headers = [
        "Authorization: Basic " ~ ($env.segment_write_key|base64_encode),
        "Content-Type: application/json"
      ]
      params = $track_payload
      timeout = 30
    } as $segment_response

    var $response_status {
      value = $segment_response.response.status
    }

    conditional {
      if ($response_status >= 400) {
        throw {
          name = "SegmentAPIError"
          value = "Segment API returned error: " ~ $response_status
        }
      }
    }

    var $response_body {
      value = $segment_response.response.body
    }
  }
  response = {
    success: true,
    user_id: $input.user_id,
    event: $input.event,
    timestamp: $iso_timestamp,
    properties: $event_properties,
    segment_response: $response_body
  }
}
