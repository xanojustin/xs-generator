function "send_novu_notification" {
  description = "Send a notification via Novu API to a subscriber"
  input {
    text subscriber_id
    text workflow_id
    json payload
  }
  stack {
    // Build the request payload
    var $request_body {
      value = {
        name: $input.workflow_id,
        to: {
          subscriberId: $input.subscriber_id
        },
        payload: $input.payload ?? {}
      }
    }

    // Call Novu API to trigger the notification
    api.request {
      url = "https://api.novu.co/v1/events/trigger"
      method = "POST"
      params = $request_body
      headers = [
        "Content-Type: application/json",
        "Authorization: ApiKey " ~ $env.NOVU_API_KEY
      ]
      timeout = 30
    } as $api_result

    // Handle the response
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $result {
          value = {
            success: true,
            transaction_id: $api_result.response.result.data.transactionId,
            status: $api_result.response.result.data.status
          }
        }
      }
      else {
        throw {
          name = "NovuAPIError"
          value = "Novu API request failed"
        }
      }
    }
  }
  response = $result
}
