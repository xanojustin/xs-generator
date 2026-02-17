function "create_hubspot_contact" {
  input {
    text email
    text first_name?
    text last_name?
    text phone?
    text company?
    text job_title?
  }
  stack {
    // Validate required field
    precondition ($input.email != null && $input.email != "") {
      error_type = "inputerror"
      error = "Email is required to create a HubSpot contact"
    }

    // Build the properties array for HubSpot API
    var $properties {
      value = [
        { property: "email", value: $input.email }
      ]
    }

    // Add optional fields if provided
    conditional {
      if ($input.first_name != null && $input.first_name != "") {
        var $fn_prop { value = { property: "firstname", value: $input.first_name } }
        var.update $properties { value = $properties|push:$fn_prop }
      }
    }

    conditional {
      if ($input.last_name != null && $input.last_name != "") {
        var $ln_prop { value = { property: "lastname", value: $input.last_name } }
        var.update $properties { value = $properties|push:$ln_prop }
      }
    }

    conditional {
      if ($input.phone != null && $input.phone != "") {
        var $phone_prop { value = { property: "phone", value: $input.phone } }
        var.update $properties { value = $properties|push:$phone_prop }
      }
    }

    conditional {
      if ($input.company != null && $input.company != "") {
        var $company_prop { value = { property: "company", value: $input.company } }
        var.update $properties { value = $properties|push:$company_prop }
      }
    }

    conditional {
      if ($input.job_title != null && $input.job_title != "") {
        var $title_prop { value = { property: "jobtitle", value: $input.job_title } }
        var.update $properties { value = $properties|push:$title_prop }
      }
    }

    // Prepare the request payload
    var $payload {
      value = { properties: $properties }
    }

    // Make the API request to HubSpot
    api.request {
      url = "https://api.hubapi.com/crm/v3/objects/contacts"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.HUBSPOT_ACCESS_TOKEN
      ]
      timeout = 30
    } as $hubspot_response

    // Check for successful response
    conditional {
      if ($hubspot_response.response.status >= 200 && $hubspot_response.response.status < 300) {
        var $result {
          value = {
            success: true,
            contact_id: $hubspot_response.response.result.id,
            email: $input.email,
            message: "Contact created successfully in HubSpot"
          }
        }
      }
      elseif ($hubspot_response.response.status == 409) {
        // Contact already exists
        var $result {
          value = {
            success: false,
            error: "Contact already exists with this email",
            email: $input.email
          }
        }
      }
      else {
        var $error_msg {
          value = "HubSpot API error: " ~ ($hubspot_response.response.status|to_text)
        }
        conditional {
          if ($hubspot_response.response.result.message != null) {
            var.update $error_msg {
              value = $error_msg ~ " - " ~ $hubspot_response.response.result.message
            }
          }
        }
        var $result {
          value = {
            success: false,
            error: $error_msg,
            status_code: $hubspot_response.response.status
          }
        }
      }
    }
  }
  response = $result
}
