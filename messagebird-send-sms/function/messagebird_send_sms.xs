function "messagebird_send_sms" {
  description = "Send an SMS using the MessageBird API"
  input {
    text recipient { description = "The phone number of the recipient in E.164 format (e.g., '+1234567890')" }
    text originator { description = "The sender ID or phone number (max 11 alphanumeric chars)" }
    text message { description = "The message body to send" }
  }
  stack {
    var $payload {
      value = {
        recipients: [$input.recipient],
        originator: $input.originator,
        body: $input.message
      }
    }

    api.request {
      url = "https://rest.messagebird.com/messages"
      method = "POST"
      params = $payload
      headers = [
        "Authorization: AccessKey " ~ $env.messagebird_api_key,
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $sms_result { value = $api_result.response.result }
      }
      else {
        throw {
          name = "MessageBirdAPIError"
          value = "MessageBird API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $sms_result
}
