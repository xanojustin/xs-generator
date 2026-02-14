function "add_contact" {
  description = "Add a contact to a Mailchimp audience"
  input {
    email email filters=trim { description = "Email address of the contact" }
    text first_name? filters=trim { description = "First name of the contact (optional)" }
    text last_name? filters=trim { description = "Last name of the contact (optional)" }
    text status?="subscribed" filters=trim { description = "Subscription status: subscribed, unsubscribed, cleaned, pending (default: subscribed)" }
    text tags? filters=trim { description = "Comma-separated list of tags to apply (optional)" }
  }

  stack {
    // Get environment variables
    var $api_key { value = $env.MAILCHIMP_API_KEY }
    var $server_prefix { value = $env.MAILCHIMP_SERVER_PREFIX }
    var $audience_id { value = $env.MAILCHIMP_AUDIENCE_ID }

    // Validate required environment variables
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "MAILCHIMP_API_KEY environment variable not configured"
    }

    precondition ($server_prefix != null && $server_prefix != "") {
      error_type = "standard"
      error = "MAILCHIMP_SERVER_PREFIX environment variable not configured"
    }

    precondition ($audience_id != null && $audience_id != "") {
      error_type = "standard"
      error = "MAILCHIMP_AUDIENCE_ID environment variable not configured"
    }

    // Validate email is provided
    precondition ($input.email != null && $input.email != "") {
      error_type = "inputerror"
      error = "Email is required"
    }

    // Build the request payload
    var $payload {
      value = {
        email_address: $input.email,
        status: $input.status
      }
    }

    // Build merge fields if name data is provided
    var $merge_fields { value = {} }

    conditional {
      if ($input.first_name != null && $input.first_name != "") {
        var $merge_fields {
          value = $merge_fields|set:"FNAME":$input.first_name
        }
      }
    }

    conditional {
      if ($input.last_name != null && $input.last_name != "") {
        var $merge_fields {
          value = $merge_fields|set:"LNAME":$input.last_name
        }
      }
    }

    // Add merge_fields to payload if not empty
    conditional {
      if (($merge_fields|get:"FNAME") != null || ($merge_fields|get:"LNAME") != null) {
        var $payload {
          value = $payload|set:"merge_fields":$merge_fields
        }
      }
    }

    // Process tags if provided
    var $tags_array { value = [] }
    conditional {
      if ($input.tags != null && $input.tags != "") {
        // Split comma-separated tags into array
        var $tags_list { value = $input.tags|split:"," }
        foreach ($tags_list) {
          each as $tag {
            var $trimmed_tag { value = $tag|trim }
            conditional {
              if ($trimmed_tag != "") {
                var $tag_obj { value = { name: $trimmed_tag, status: "active" } }
                var $tags_array {
                  value = $tags_array|merge:[$tag_obj]
                }
              }
            }
          }
        }
      }
    }

    // Add tags to payload if any were processed
    conditional {
      if (($tags_array|count) > 0) {
        var $payload {
          value = $payload|set:"tags":$tags_array
        }
      }
    }

    // Build the API URL
    var $api_url {
      value = "https://" ~ $server_prefix ~ ".api.mailchimp.com/3.0/lists/" ~ $audience_id ~ "/members"
    }

    // Send the request to Mailchimp
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $member_id { value = null }
    var $contact_email { value = null }
    var $contact_status { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200 || $api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $member_id { value = $response_body|get:"id" }
        var $contact_email { value = $response_body|get:"email_address" }
        var $contact_status { value = $response_body|get:"status" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Mailchimp API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_detail { value = $api_result.response.result|get:"detail" }
            var $error_title { value = $api_result.response.result|get:"title" }
            conditional {
              if ($error_detail != null) {
                var $error_message {
                  value = $error_detail
                }
              }
              elseif ($error_title != null) {
                var $error_message {
                  value = $error_title
                }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    member_id: $member_id,
    email: $contact_email,
    status: $contact_status,
    error: $error_message
  }
}
