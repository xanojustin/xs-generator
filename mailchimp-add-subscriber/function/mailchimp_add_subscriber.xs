function "mailchimp_add_subscriber" {
  description = "Add a subscriber to a Mailchimp audience/list"
  
  input {
    text email { 
      description = "Subscriber email address" 
    }
    text first_name { 
      description = "Subscriber first name (optional)" 
    }
    text last_name { 
      description = "Subscriber last name (optional)" 
    }
    text audience_id { 
      description = "Mailchimp audience/list ID" 
    }
  }
  
  stack {
    // Validate required inputs
    precondition (($input.email|strlen) > 0) {
      error_type = "inputerror"
      error = "Email address is required"
    }
    
    precondition (($input.audience_id|strlen) > 0) {
      error_type = "inputerror"
      error = "Audience ID is required"
    }
    
    // Get API credentials from environment
    var $api_key { 
      value = $env.mailchimp_api_key 
    }
    var $server_prefix { 
      value = $env.mailchimp_server_prefix 
    }
    
    precondition (($api_key|strlen) > 0) {
      error_type = "inputerror"
      error = "Mailchimp API key not configured. Set mailchimp_api_key environment variable."
    }
    
    precondition (($server_prefix|strlen) > 0) {
      error_type = "inputerror"
      error = "Mailchimp server prefix not configured. Set mailchimp_server_prefix environment variable."
    }
    
    // Build the merge_fields object conditionally
    var $merge_fields { value = {} }
    
    conditional {
      if (($input.first_name|strlen) > 0) {
        var $merge_fields { 
          value = $merge_fields|set:"FNAME":$input.first_name 
        }
      }
    }
    
    conditional {
      if (($input.last_name|strlen) > 0) {
        var $merge_fields { 
          value = $merge_fields|set:"LNAME":$input.last_name 
        }
      }
    }
    
    // Build the request payload
    var $payload { 
      value = {
        email_address: $input.email,
        status: "subscribed"
      }
    }
    
    // Add merge_fields only if we have name data
    conditional {
      if (($merge_fields|keys|count) > 0) {
        var $payload { 
          value = $payload|set:"merge_fields":$merge_fields 
        }
      }
    }
    
    // Make the API request to Mailchimp
    // Note: Mailchimp uses HTTP Basic Auth with apikey as username and API key as password
    api.request {
      url = "https://" ~ $server_prefix ~ ".api.mailchimp.com/3.0/lists/" ~ $input.audience_id ~ "/members"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ ("apikey:" ~ $api_key)|base64_encode
      ]
      timeout = 30
    } as $api_result
    
    // Handle the response
    conditional {
      if (($api_result.response.status >= 200) && ($api_result.response.status < 300)) {
        // Success - subscriber added
        var $subscriber { 
          value = $api_result.response.result 
        }
      }
      elseif ($api_result.response.status == 400) {
        // Bad request - likely invalid email or already subscribed
        throw {
          name = "MailchimpBadRequest"
          value = "Mailchimp rejected the request: " ~ ($api_result.response.result|json_encode)
        }
      }
      elseif ($api_result.response.status == 401) {
        // Unauthorized - invalid API key
        throw {
          name = "MailchimpAuthError"
          value = "Authentication failed. Check your Mailchimp API key."
        }
      }
      elseif ($api_result.response.status == 404) {
        // Not found - invalid audience ID
        throw {
          name = "MailchimpNotFound"
          value = "Audience/list not found. Check your audience ID."
        }
      }
      else {
        // Other errors
        throw {
          name = "MailchimpAPIError"
          value = "Mailchimp API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  
  response = $subscriber
}