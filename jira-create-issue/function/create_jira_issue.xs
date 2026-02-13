function "create_jira_issue" {
  description = "Creates a new issue in Jira via the REST API"
  input {
    text project_key filters=trim
    text summary filters=trim
    text issue_type="Task" filters=trim
    text? description
    text? priority
    text[]? labels
  }
  stack {
    // Build the request body for Jira API
    var $request_body {
      value = {
        fields: {
          project: {
            key: $input.project_key
          },
          summary: $input.summary,
          issuetype: {
            name: $input.issue_type
          }
        }
      }
    }

    // Add optional description if provided
    conditional {
      if ($input.description != null) {
        conditional {
          if (($input.description|strlen) > 0) {
            var.update $request_body.fields.description {
              value = $input.description
            }
          }
        }
      }
    }

    // Add optional priority if provided
    conditional {
      if ($input.priority != null) {
        conditional {
          if (($input.priority|strlen) > 0) {
            var.update $request_body.fields.priority {
              value = {
                name: $input.priority
              }
            }
          }
        }
      }
    }

    // Add optional labels if provided
    conditional {
      if ($input.labels != null) {
        conditional {
          if (($input.labels|count) > 0) {
            var.update $request_body.fields.labels {
              value = $input.labels
            }
          }
        }
      }
    }

    // Build Authorization header using Basic Auth (email:token)
    var $auth_string {
      value = $env.JIRA_EMAIL ~ ":" ~ $env.JIRA_API_TOKEN
    }

    var $encoded_auth {
      value = $auth_string|base64_encode
    }

    var $auth_header {
      value = "Authorization: Basic " ~ $encoded_auth
    }

    // Make the API request to Jira
    api.request {
      url = $env.JIRA_BASE_URL ~ "/rest/api/2/issue"
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "Accept: application/json",
        $auth_header
      ]
      params = $request_body
      timeout = 30
    } as $api_result

    // Check for successful response
    precondition ($api_result.response.status >= 200) {
      error_type = "standard"
      error = "Jira API request failed"
    }

    // Extract the created issue data
    var $issue_data {
      value = $api_result.response.result
    }

    // Build success response
    var $result {
      value = {
        success: true,
        issue_key: $issue_data.key,
        issue_id: $issue_data.id,
        issue_url: $env.JIRA_BASE_URL ~ "/browse/" ~ $issue_data.key,
        message: "Issue created successfully"
      }
    }
  }
  response = $result
}
