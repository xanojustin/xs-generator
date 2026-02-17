function "segment_track" {
  description = "Send a track event to Segment analytics API"
  input {
    text event { description = "The event name (e.g., 'Order Completed', 'Signed Up')" }
    text user_id { description = "The unique identifier for the user" }
    object properties {
      description = "Additional properties for the event"
      schema {
        text order_id?
        decimal total?
        text currency?
        int product_count?
      }
    }
  }
  stack {
    var $payload {
      value = {
        event: $input.event,
        userId: $input.user_id,
        properties: $input.properties,
        timestamp: now
      }
    }

    api.request {
      url = "https://api.segment.io/v1/track"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ ($env.segment_write_key ~ ":"|base64_encode)
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $result { value = { success: true } }
      }
      else {
        throw {
          name = "SegmentAPIError"
          value = "Segment API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $result
}