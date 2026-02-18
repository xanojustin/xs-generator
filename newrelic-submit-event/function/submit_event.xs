function "submit_event" {
  description = "Submit a custom event to New Relic Insights API"
  
  input {
    text event_type
    text account_id
    json event_data
  }

  stack {
    // Validate required inputs
    precondition ($input.event_type != "" && $input.event_type != null) {
      error_type = "inputerror"
      error = "event_type is required"
    }

    precondition ($input.account_id != "" && $input.account_id != null) {
      error_type = "inputerror"
      error = "account_id is required"
    }

    precondition ($input.event_data != null) {
      error_type = "inputerror"
      error = "event_data is required"
    }

    // Build the event payload - New Relic expects an array of event objects
    var $payload {
      value = [
        {
          eventType: $input.event_type
        } ~ $input.event_data
      ]
    }

    // Submit the event to New Relic Insights API
    api.request {
      url = "https://insights-collector.newrelic.com/v1/accounts/" ~ $input.account_id ~ "/events"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "X-Insert-Key: " ~ $env.NEW_RELIC_INSERT_KEY
      ]
      timeout = 30
    } as $nr_result

    // Handle New Relic response
    conditional {
      if ($nr_result.response.status == 200) {
        var $result {
          value = {
            success: true,
            event_type: $input.event_type,
            account_id: $input.account_id,
            events_accepted: $nr_result.response.result.success ?? true,
            message: $nr_result.response.result.message ?? "Event submitted successfully"
          }
        }

        // Log the successful submission
        db.add event_log {
          data = {
            event_type: $input.event_type,
            account_id: $input.account_id,
            event_data: $payload|json_encode,
            status: "success",
            http_status: $nr_result.response.status,
            created_at: now
          }
        } as $log_entry
      }
      elseif ($nr_result.response.status == 401 || $nr_result.response.status == 403) {
        var $error_msg {
          value = "Authentication failed: Invalid New Relic Insert API Key"
        }

        // Log the failed submission
        db.add event_log {
          data = {
            event_type: $input.event_type,
            account_id: $input.account_id,
            event_data: $payload|json_encode,
            status: "auth_error",
            http_status: $nr_result.response.status,
            error_message: $error_msg,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "AuthenticationError"
          value = $error_msg
        }
      }
      elseif ($nr_result.response.status == 400) {
        var $error_msg {
          value = "Bad request: " ~ ($nr_result.response.result.error ?? "Invalid event data format")
        }

        // Log the failed submission
        db.add event_log {
          data = {
            event_type: $input.event_type,
            account_id: $input.account_id,
            event_data: $payload|json_encode,
            status: "validation_error",
            http_status: $nr_result.response.status,
            error_message: $error_msg,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "ValidationError"
          value = $error_msg
        }
      }
      else {
        var $error_msg {
          value = "New Relic API error (HTTP " ~ ($nr_result.response.status|to_text) ~ "): " ~ ($nr_result.response.result.error ?? "Unknown error")
        }

        // Log the failed submission
        db.add event_log {
          data = {
            event_type: $input.event_type,
            account_id: $input.account_id,
            event_data: $payload|json_encode,
            status: "api_error",
            http_status: $nr_result.response.status,
            error_message: $error_msg,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "NewRelicAPIError"
          value = $error_msg
        }
      }
    }
  }

  response = $result
}
