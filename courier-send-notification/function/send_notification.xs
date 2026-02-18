function "send_courier_notification" {
  description = "Send a notification using the Courier API"
  input {
    text template_id filters=trim {
      description = "Courier template ID to use for the notification"
    }
    text recipient_email filters=trim {
      description = "Email address of the recipient"
    }
    text recipient_id?="" filters=trim {
      description = "Optional unique identifier for the recipient"
    }
    json data? {
      description = "Optional data object to pass to the template"
    }
  }
  stack {
    // Generate recipient ID from email if not provided
    var $final_recipient_id {
      value = ($input.recipient_id != "") ? $input.recipient_id : $input.recipient_email
    }

    // Set default data if not provided
    var $template_data {
      value = ($input.data != null) ? $input.data : {}
    }

    // Build the Courier API payload
    var $courier_payload {
      value = {
        message: {
          to: {
            email: $input.recipient_email
          }
          template: $input.template_id
          data: $template_data
        }
      }
    }

    // Add recipient_id to the 'to' object if we have one different from email
    conditional {
      if (`$final_recipient_id != $input.recipient_email`) {
        var $courier_payload {
          value = {
            message: {
              to: {
                user_id: $final_recipient_id
                email: $input.recipient_email
              }
              template: $input.template_id
              data: $template_data
            }
          }
        }
      }
    }

    // Send the notification via Courier API
    api.request {
      url = "https://api.courier.com/send"
      method = "POST"
      params = $courier_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.COURIER_AUTH_TOKEN
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    precondition ($api_result.response.status == 200 || $api_result.response.status == 202) {
      error_type = "standard"
      error = "Courier API request failed with status: " ~ ($api_result.response.status|to_text) ~ " - " ~ ($api_result.response.result|json_encode)
    }

    // Extract the request ID from the response
    var $request_id {
      value = $api_result.response.result.requestId
    }

    // Build the success response
    var $response_data {
      value = {
        success: true
        request_id: $request_id
        status: "queued"
        recipient: $input.recipient_email
        template: $input.template_id
      }
    }
  }
  response = $response_data
}
