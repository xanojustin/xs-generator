function "linear_create_issue" {
  description = "Create a new issue in Linear using the GraphQL API"

  input {
    text title filters=trim|min:1 {
      description = "The title of the issue to create"
    }

    text? description? {
      description = "Optional description/body of the issue"
    }

    text? team_id? {
      description = "Optional team ID to assign the issue to"
    }

    text? state_id? {
      description = "Optional workflow state ID (backlog, todo, etc.)"
    }

    text? assignee_id? {
      description = "Optional user ID to assign the issue to"
    }

    text[]? label_ids? {
      description = "Optional array of label IDs to apply to the issue"
    }

    int? priority? {
      description = "Optional priority: 0 (no priority), 1 (urgent), 2 (high), 3 (medium), 4 (low)"
    }
  }

  stack {
    var $mutation_input {
      description = "Build the mutation input object"
      value = {}|set:"title":$input.title
    }

    conditional {
      description = "Add description if provided"
      if ($input.description != null && $input.description != "") {
        var.update $mutation_input {
          value = $mutation_input|set:"description":$input.description
        }
      }
    }

    conditional {
      description = "Add team ID if provided"
      if ($input.team_id != null && $input.team_id != "") {
        var.update $mutation_input {
          value = $mutation_input|set:"teamId":$input.team_id
        }
      }
    }

    conditional {
      description = "Add state ID if provided"
      if ($input.state_id != null && $input.state_id != "") {
        var.update $mutation_input {
          value = $mutation_input|set:"stateId":$input.state_id
        }
      }
    }

    conditional {
      description = "Add assignee ID if provided"
      if ($input.assignee_id != null && $input.assignee_id != "") {
        var.update $mutation_input {
          value = $mutation_input|set:"assigneeId":$input.assignee_id
        }
      }
    }

    conditional {
      description = "Add label IDs if provided"
      if ($input.label_ids != null && ($input.label_ids|count) > 0) {
        var.update $mutation_input {
          value = $mutation_input|set:"labelIds":$input.label_ids
        }
      }
    }

    conditional {
      description = "Add priority if provided"
      if ($input.priority != null) {
        var.update $mutation_input {
          value = $mutation_input|set:"priority":$input.priority
        }
      }
    }

    var $query {
      description = "GraphQL mutation to create issue"
      value = """
        mutation IssueCreate($input: IssueCreateInput!) {
          issueCreate(input: $input) {
            success
            issue {
              id
              identifier
              title
              url
              state {
                name
              }
              priority
              createdAt
            }
          }
        }
      """
    }

    api.request {
      description = "Send GraphQL request to Linear API"
      url = "https://api.linear.app/graphql"
      method = "POST"
      params = {}|set:"query":$query|set:"variables":({}|set:"input":$mutation_input)
      headers = []|push:"Content-Type: application/json"|push:"Authorization: " ~ $env.linear_api_key
    } as $api_response

    var $success {
      description = "Check if the mutation succeeded"
      value = $api_response|get:"data.issueCreate.success":false
    }

    precondition ($success == true) {
      error_type = "standard"
      error = "Failed to create Linear issue"
    }

    var $issue {
      description = "Extract created issue data"
      value = $api_response|get:"data.issueCreate.issue":null
    }

    var $result {
      description = "Build success response"
      value = {
        success: true
        issue: $issue
        message: "Issue created successfully: " ~ ($issue|get:"identifier":"")
      }
    }
  }

  response = $result
}
