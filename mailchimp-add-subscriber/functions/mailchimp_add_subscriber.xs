function "mailchimp_add_subscriber" {
  description = "Add a subscriber to a Mailchimp audience/list"
  input {
    email subscriber_email filters=trim
    text first_name? filters=trim
    text last_name? filters=trim
    text status? filters=trim
  }
  stack {
    precondition (($input.subscriber_email|is_empty) == false) {
      error_type = "inputerror"
      error = "Subscriber email is required"
    }

    precondition (($env.mailchimp_api_key|is_empty) == false) {
      error_type = "badrequest"
      error = "Mailchimp API key is not configured"
    }

    precondition (($env.mailchimp_server_prefix|is_empty) == false) {
      error_type = "badrequest"
      error = "Mailchimp server prefix is not configured"
    }

    precondition (($env.mailchimp_list_id|is_empty) == false) {
      error_type = "badrequest"
      error = "Mailchimp list ID is not configured"
    }

    var $subscriber_hash {
      value = $input.subscriber_email|md5
    }

    var $subscriber_status {
      value = ($input.status|is_empty) == false ? $input.status : "subscribed"
    }

    var $merge_fields {
      value = ($input.first_name|is_empty) == false ? {FNAME: $input.first_name} : {}
    }

    var $merge_fields {
      value = ($input.last_name|is_empty) == false ? $merge_fields + {LNAME: $input.last_name} : $merge_fields
    }

    var $request_body {
      value = {
        email_address: $input.subscriber_email,
        status: $subscriber_status
      }
    }

    var $request_body {
      value = ($merge_fields|count) > 0 ? $request_body + {merge_fields: $merge_fields} : $request_body
    }

    var $api_url {
      value = "https://" ~ $env.mailchimp_server_prefix ~ ".api.mailchimp.com/3.0/lists/" ~ $env.mailchimp_list_id ~ "/members/" ~ $subscriber_hash
    }

    api.request {
      url = $api_url
      method = "PUT"
      headers = [
        "Authorization: Bearer " ~ $env.mailchimp_api_key,
        "Content-Type: application/json"
      ]
      params = $request_body
    } as $api_result

    var $response_status {
      value = $api_result.response.status
    }

    var $is_success {
      value = ($response_status == 200) || ($response_status == 201)
    }

    precondition ($is_success) {
      error_type = "standard"
      error = "Failed to add subscriber: " ~ $api_result.response.body.detail
    }

    var $response_body {
      value = $api_result.response.body
    }
  }
  response = {
    success: true,
    email: $input.subscriber_email,
    subscriber_id: $response_body.id,
    list_id: $response_body.list_id,
    status: $response_body.status,
    first_name: $input.first_name,
    last_name: $input.last_name
  }
}
