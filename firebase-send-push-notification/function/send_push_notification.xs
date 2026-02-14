function "send_push_notification" {
  description = "Send a push notification via Firebase Cloud Messaging (FCM) v1 API"
  input {
    text device_token { description = "FCM device registration token" }
    text title { description = "Notification title" }
    text body { description = "Notification body message" }
    text image_url? filters=trim {
      description = "Optional image URL for notification"
    }
    json data? {
      description = "Optional custom data payload"
    }
  }
  stack {
    // Validate required inputs
    precondition ($input.device_token != null && $input.device_token != "") {
      error_type = "inputerror"
      error = "Device token is required"
    }

    precondition ($input.title != null && $input.title != "") {
      error_type = "inputerror"
      error = "Notification title is required"
    }

    precondition ($input.body != null && $input.body != "") {
      error_type = "inputerror"
      error = "Notification body is required"
    }

    // Build the notification payload
    var $notification {
      value = {
        token: $input.device_token,
        notification: {
          title: $input.title,
          body: $input.body
        }
      }
    }

    // Add optional image if provided
    conditional {
      if ($input.image_url != null && $input.image_url != "") {
        var $notification_with_image {
          value = $notification|set:"notification":{
            title: $input.title,
            body: $input.body,
            image: $input.image_url
          }
        }
        var $notification { value = $notification_with_image }
      }
    }

    // Add optional data payload if provided
    conditional {
      if ($input.data != null) {
        var $notification_with_data {
          value = $notification|set:"data":$input.data
        }
        var $notification { value = $notification_with_data }
      }
    }

    // Construct the FCM v1 API URL
    var $fcm_url {
      value = "https://fcm.googleapis.com/v1/projects/" ~ $env.FIREBASE_PROJECT_ID ~ "/messages:send"
    }

    // Get OAuth2 access token from service account key
    // Note: In production, you would use a proper OAuth2 flow
    // For this example, we assume the access token is provided via environment
    var $access_token {
      value = $env.FIREBASE_SERVICE_ACCOUNT_KEY
    }

    // Send the push notification via FCM API
    api.request {
      url = $fcm_url
      method = "POST"
      params = { message: $notification }
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $access_token
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "FCM API error: " ~ ($api_result.response.status|to_text) ~ " - " ~ ($api_result.response.result|json_encode)
    }

    // Extract the message ID from response
    var $message_id {
      value = $api_result.response.result.name|first_notnull:""
    }

    // Build success response
    var $result {
      value = {
        success: true,
        message_id: $message_id,
        status: $api_result.response.status,
        device_token: $input.device_token|slice:0:20 ~ "..."
      }
    }
  }
  response = $result
}
