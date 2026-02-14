function "jira_create_issue" {
  description = "Create a new issue in Jira"
  input {
    text project_key filters=trim { description = "Jira project key (e.g., PROJ, DEV, TEST)" }
    text summary filters=trim { description = "Issue summary/title" }
    text description? filters=trim { description = "Issue description (optional)" }
    text issue_type?="Task" filters=trim { description = "Issue type (Bug, Task, Story, Epic). Default: Task" }
    text priority? filters=trim { description = "Priority (Highest, High, Medium, Low, Lowest). Optional." }
    text assignee_account_id? filters=trim { description = "Jira account ID to assign the issue to. Optional." }
    text[] labels? { description = "Array of label strings. Optional." }
  }
  stack {
    // Build the issue fields
    var $issue_fields {
      value = {
        project: { key: $input.project_key },
        summary: $input.summary,
        issuetype: { name: $input.issue_type }
      }
    }

    // Add description if provided
    conditional {
      if ($input.description != null && $input.description != "") {
        var $fields_with_desc {
          value = $issue_fields|set:"description":{
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
        var.update $issue_fields { value = $fields_with_desc }
      }
    }

    // Add priority if provided
    conditional {
      if ($input.priority != null && $input.priority != "") {
        var $fields_with_priority {
          value = $issue_fields|set:"priority":{ name: $input.priority }
        }
        var.update $issue_fields { value = $fields_with_priority }
      }
    }

    // Add assignee if provided
    conditional {
      if ($input.assignee_account_id != null && $input.assignee_account_id != "") {
        var $fields_with_assignee {
          value = $issue_fields|set:"assignee":{ accountId: $input.assignee_account_id }
        }
        var.update $issue_fields { value = $fields_with_assignee }
      }
    }

    // Add labels if provided
    conditional {
      if ($input.labels != null && ($input.labels|count) > 0) {
        var $fields_with_labels {
          value = $issue_fields|set:"labels":$input.labels
        }
        var.update $issue_fields { value = $fields_with_labels }
      }
    }

    // Build the request payload
    var $payload {
      value = { fields: $issue_fields }
    }

    // Make the API request to Jira
    api.request {
      url = ($env.jira_base_url ~ "/rest/api/3/issue")
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ $env.jira_api_token
      ]
      timeout = 30
    } as $api_result

    // Check for success
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $result {
          value = {
            success: true,
            issue_key: $api_result.response.result.key,
            issue_id: $api_result.response.result.id,
            self_url: $api_result.response.result.self,
            message: "Issue created successfully: " ~ $api_result.response.result.key
          }
        }
      }
      else {
        var $error_message {
          value = "Jira API error: " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result.errorMessages != null) {
            var.update $error_message {
              value = $error_message ~ " - " ~ ($api_result.response.result.errorMessages|json_encode)
            }
          }
        }
        throw {
          name = "JiraAPIError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}
