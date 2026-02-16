// WorkOS Create Organization Function
// Creates a new organization in WorkOS for enterprise SSO
function "create_workos_organization" {
  input {
    text name
    text? domain
    text? external_id
    json? metadata
  }
  stack {
    // Validate required fields
    precondition ($input.name != null && $input.name != "") {
      error_type = "inputerror"
      error = "Organization name is required"
    }
    // Build request payload
    var $payload {
      value = { name: $input.name }
    }
    // Add optional domain if provided
    conditional {
      if ($input.domain != null && $input.domain != "") {
        var $domains { value = [$input.domain] }
        var.update $payload { 
          value = $payload|set:"domains":$domains 
        }
      }
    }
    // Add optional external_id if provided
    conditional {
      if ($input.external_id != null && $input.external_id != "") {
        var.update $payload { 
          value = $payload|set:"external_id":$input.external_id 
        }
      }
    }
    // Add optional metadata if provided
    conditional {
      if ($input.metadata != null) {
        var.update $payload { 
          value = $payload|set:"metadata":$input.metadata 
        }
      }
    }
    // Make request to WorkOS API
    api.request {
      url = "https://api.workos.com/organizations"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.WORKOS_API_KEY
      ]
      timeout = 30
    } as $api_result
    // Handle response
    conditional {
      if ($api_result.response.status == 201) {
        // Success - organization created
        var $organization { value = $api_result.response.result }
      }
      elseif ($api_result.response.status == 409) {
        // Conflict - organization already exists
        throw {
          name = "ConflictError"
          value = "An organization with this domain already exists"
        }
      }
      elseif ($api_result.response.status == 401) {
        // Unauthorized
        throw {
          name = "AuthError"
          value = "Invalid WorkOS API key"
        }
      }
      else {
        // Other errors
        var $status_text { value = $api_result.response.status|to_text }
        throw {
          name = "APIError"
          value = "WorkOS API error: " ~ $status_text
        }
      }
    }
    // Log success
    debug.log {
      value = "Created WorkOS organization: " ~ $organization.name ~ " (ID: " ~ $organization.id ~ ")"
    }
  }
  response = $organization
}
