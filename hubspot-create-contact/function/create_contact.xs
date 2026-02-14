function "create_contact" {
  description = "Create a contact in HubSpot CRM"
  input {
    text email filters=trim { description = "Contact email address (required, must be unique)" }
    text firstname? filters=trim { description = "Contact first name (optional)" }
    text lastname? filters=trim { description = "Contact last name (optional)" }
    text company? filters=trim { description = "Company name (optional)" }
    text phone? filters=trim { description = "Phone number (optional)" }
    text jobtitle? filters=trim { description = "Job title (optional)" }
    text lifecyclestage?="subscriber" filters=trim { description = "Lifecycle stage: subscriber, lead, marketingqualifiedlead, salesqualifiedlead, opportunity, customer, evangelist, other (optional, default: subscriber)" }
  }

  stack {
    // Get API token from environment
    var $access_token { value = $env.HUBSPOT_ACCESS_TOKEN }

    // Validate API token is configured
    precondition ($access_token != null && $access_token != "") {
      error_type = "standard"
      error = "HUBSPOT_ACCESS_TOKEN environment variable not configured"
    }

    // Validate email is provided
    precondition ($input.email != null && $input.email != "") {
      error_type = "inputerror"
      error = "Email is required to create a HubSpot contact"
    }

    // Validate email format (basic check)
    precondition ($input.email|contains:"@") {
      error_type = "inputerror"
      error = "Invalid email format"
    }

    // Build the properties object for HubSpot API
    var $properties {
      value = {
        email: $input.email
      }
    }

    // Add optional fields if provided
    conditional {
      if ($input.firstname != null && $input.firstname != "") {
        var.update $properties {
          value = $properties|set:"firstname":$input.firstname
        }
      }
    }

    conditional {
      if ($input.lastname != null && $input.lastname != "") {
        var.update $properties {
          value = $properties|set:"lastname":$input.lastname
        }
      }
    }

    conditional {
      if ($input.company != null && $input.company != "") {
        var.update $properties {
          value = $properties|set:"company":$input.company
        }
      }
    }

    conditional {
      if ($input.phone != null && $input.phone != "") {
        var.update $properties {
          value = $properties|set:"phone":$input.phone
        }
      }
    }

    conditional {
      if ($input.jobtitle != null && $input.jobtitle != "") {
        var.update $properties {
          value = $properties|set:"jobtitle":$input.jobtitle
        }
      }
    }

    conditional {
      if ($input.lifecyclestage != null && $input.lifecyclestage != "") {
        var.update $properties {
          value = $properties|set:"lifecyclestage":$input.lifecyclestage
        }
      }
    }

    // Build the request payload
    var $payload {
      value = {
        properties: $properties
      }
    }

    // Send the request to HubSpot
    api.request {
      url = "https://api.hubapi.com/crm/v3/objects/contacts"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $access_token
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $contact_id { value = null }
    var $created_at { value = null }
    var $error_message { value = null }
    var $response_properties { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $contact_id { value = $response_body|get:"id" }
        var $created_at { value = $response_body|get:"createdAt" }
        var $response_properties { value = $response_body|get:"properties" }
      }
      elseif ($api_result.response.status == 409) {
        // Conflict - contact already exists
        var $success { value = false }
        var $error_message { value = "Contact with this email already exists in HubSpot" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "HubSpot API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"message" }
            conditional {
              if ($error_obj != null) {
                var $error_message {
                  value = $error_obj
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
    contact_id: $contact_id,
    created_at: $created_at,
    properties: $response_properties,
    error: $error_message
  }
}
