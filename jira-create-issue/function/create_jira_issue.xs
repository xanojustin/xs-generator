function "create_jira_issue" {
  input {
    text project_key
    text summary
    text issue_type
    text description?=""
    text priority?="Medium"
    text assignee?=""
  }
  stack {
    // Validate required inputs
    precondition ($input.project_key != "" && $input.project_key != null) {
      error_type = "inputerror"
      error = "project_key is required"
    }
    precondition ($input.summary != "" && $input.summary != null) {
      error_type = "inputerror"
      error = "summary is required"
    }

    // Build the issue payload
    var $issue_data {
      value = {
        fields: {
          project: { key: $input.project_key },
          summary: $input.summary,
          issuetype: { name: $input.issue_type }
        }
      }
    }

    // Add description if provided
    conditional {
      if ($input.description != "") {
        var $fields {
          value = $issue_data.value.fields|set:"description":{
            type: "doc",
            version: 1,
            content: [
              {
                type: "paragraph",
                content: [
                  { type: "text", text: $input.description }
                ]
              }
            ]
          }
        }
        var.update $issue_data { value = $issue_data.value|set:"fields":$fields }
      }
    }

    // Add priority if provided
    conditional {
      if ($input.priority != "") {
        var $fields_with_priority {
          value = $issue_data.value.fields|set:"priority":{ name: $input.priority }
        }
        var.update $issue_data { value = $issue_data.value|set:"fields":$fields_with_priority }
      }
    }

    // Build authorization header (Basic auth with email:token)
    var $auth_string {
      value = $env.JIRA_USER_EMAIL ~ ":" ~ $env.JIRA_API_TOKEN
    }
    var $encoded_auth {
      value = $auth_string.value|base64_encode
    }

    // Make the API request to Jira
    api.request {
      url = $env.JIRA_BASE_URL ~ "/rest/api/3/issue"
      method = "POST"
      params = $issue_data.value
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ $encoded_auth.value
      ]
      timeout = 30
    } as $api_result

    // Handle response
    conditional {
      if ($api_result.response.status == 201) {
        // Success - issue created
        var $created_issue {
          value = {
            success: true,
            issue_key: $api_result.response.result.key,
            issue_id: $api_result.response.result.id,
            self_url: $api_result.response.result.self,
            message: "Issue " ~ $api_result.response.result.key ~ " created successfully"
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        // Bad request - validation error
        throw {
          name = "JiraValidationError"
          value = "Validation error: " ~ ($api_result.response.result.errors|json_encode)
        }
      }
      elseif ($api_result.response.status == 401) {
        // Unauthorized
        throw {
          name = "JiraAuthError"
          value = "Authentication failed. Check JIRA_API_TOKEN and JIRA_USER_EMAIL."
        }
      }
      elseif ($api_result.response.status == 403) {
        // Forbidden
        throw {
          name = "JiraPermissionError"
          value = "Permission denied. Check your Jira account has create issue permissions."
        }
      }
      elseif ($api_result.response.status == 404) {
        // Not found - project doesn't exist
        throw {
          name = "JiraNotFoundError"
          value = "Project '" ~ $input.project_key ~ "' not found or you don't have access."
        }
      }
      else {
        // Other errors
        throw {
          name = "JiraAPIError"
          value = "Jira API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $created_issue.value
}
