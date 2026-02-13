function "send_slack_message" {
  description = "Send a message to a Slack channel using the Slack API"
  input {
  }
  stack {
    // Get configuration from environment variables
    var $bot_token {
      value = $env.slack_bot_token
    }
    var $channel {
      value = $env.slack_channel
    }
    var $message {
      value = $env.slack_message
    }

    // Validate required fields
    conditional {
      if ($bot_token == null) {
        var $result {
          value = {
            status: "error",
            message: "slack_bot_token is required"
          }
        }
      }
      else {
        conditional {
          if ($channel == null) {
            var $result {
              value = {
                status: "error",
                message: "slack_channel is required"
              }
            }
          }
          else {
            conditional {
              if ($message == null) {
                var $result {
                  value = {
                    status: "error",
                    message: "slack_message is required"
                  }
                }
              }
              else {
                // Build the Slack API URL
                var $slack_url {
                  value = "https://slack.com/api/chat.postMessage"
                }

                // Create Authorization header with Bearer token
                var $auth_header {
                  value = "Authorization: Bearer " ~ $bot_token
                }

                // Prepare JSON payload for the request
                var $payload {
                  value = {
                    channel: $channel,
                    text: $message
                  }
                }

                // Make the API request to Slack
                api.request {
                  url = $slack_url
                  method = "POST"
                  params = $payload
                  headers = [
                    "Content-Type: application/json; charset=utf-8",
                    $auth_header
                  ]
                  timeout = 30
                } as $api_result

                // Check if the request was successful
                var $http_status {
                  value = $api_result.response.status
                }

                var $response_data {
                  value = $api_result.response.result
                }

                conditional {
                  if ($http_status == 200) {
                    // Check Slack API response (Slack returns 200 even for errors)
                    conditional {
                      if ($response_data.ok == true) {
                        // Message sent successfully
                        var $result {
                          value = {
                            status: "success",
                            message: "Message sent successfully to " ~ $channel,
                            channel: $response_data.channel,
                            timestamp: $response_data.ts,
                            slack_response: $response_data
                          }
                        }
                      }
                      else {
                        // Slack API returned an error
                        var $error_message {
                          value = ($response_data.error != null) ? $response_data.error : "Unknown Slack error"
                        }
                        var $result {
                          value = {
                            status: "error",
                            message: "Slack API error: " ~ $error_message,
                            slack_response: $response_data
                          }
                        }
                      }
                    }
                  }
                  else {
                    // HTTP error
                    var $status_text {
                      value = $http_status|to_text
                    }
                    var $result {
                      value = {
                        status: "error",
                        message: "HTTP request failed. Status: " ~ $status_text,
                        slack_response: $response_data
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  response = $result
}
