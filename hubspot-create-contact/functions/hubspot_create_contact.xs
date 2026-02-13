function "hubspot_create_contact" {
  description = "Create or update a contact in HubSpot CRM"
  input {
    email email filters=trim|lower
    text firstname? filters=trim
    text lastname? filters=trim
    text phone? filters=trim
    text company? filters=trim
    text jobtitle? filters=trim
    text lifecyclestage? filters=trim|lower
  }
  stack {
    precondition (($input.email|is_empty) == false) {
      error_type = "inputerror"
      error = "Email is required to create a HubSpot contact"
    }

    var $contact_properties {
      value = {
        email: $input.email
      }
    }

    conditional {
      if (($input.firstname|is_empty) == false) {
        var.update $contact_properties.firstname {
          value = $input.firstname
        }
      }
    }

    conditional {
      if (($input.lastname|is_empty) == false) {
        var.update $contact_properties.lastname {
          value = $input.lastname
        }
      }
    }

    conditional {
      if (($input.phone|is_empty) == false) {
        var.update $contact_properties.phone {
          value = $input.phone
        }
      }
    }

    conditional {
      if (($input.company|is_empty) == false) {
        var.update $contact_properties.company {
          value = $input.company
        }
      }
    }

    conditional {
      if (($input.jobtitle|is_empty) == false) {
        var.update $contact_properties.jobtitle {
          value = $input.jobtitle
        }
      }
    }

    conditional {
      if (($input.lifecyclestage|is_empty) == false) {
        var.update $contact_properties.lifecyclestage {
          value = $input.lifecyclestage
        }
      }
    }

    var $request_body {
      value = {
        properties: $contact_properties
      }
    }

    api.request {
      url = "https://api.hubapi.com/crm/v3/objects/contacts"
      method = "POST"
      headers = [
        "Authorization: Bearer " ~ $env.hubspot_access_token,
        "Content-Type: application/json"
      ]
      params = $request_body
    } as $api_result

    var $response_status {
      value = $api_result.response.status
    }

    var $response_body {
      value = $api_result.response.body
    }

    conditional {
      if ($response_status == 409) {
        throw {
          name = "ConflictError"
          value = "Contact already exists with email: " ~ $input.email
        }
      }
    }

    precondition ($response_status == 201) {
      error_type = "standard"
      error = "Failed to create HubSpot contact"
    }

    var $contact_id {
      value = $response_body.id
    }

    var $created_at {
      value = $response_body.createdAt
    }

    var $archived {
      value = $response_body.archived
    }
  }
  response = {
    success: true,
    contact_id: $contact_id,
    email: $input.email,
    firstname: $contact_properties.firstname,
    lastname: $contact_properties.lastname,
    company: $contact_properties.company,
    created_at: $created_at,
    archived: $archived
  }
}
