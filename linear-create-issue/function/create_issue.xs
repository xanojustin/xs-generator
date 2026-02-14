function "create_linear_issue" {
  input {
    text title
    text description
    text team_key
  }
  stack {
    var $api_key { value = $env.linear_api_key }
    
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "Linear API key is required. Set the linear_api_key environment variable."
    }
    
    precondition ($input.title != null && $input.title != "") {
      error_type = "inputerror"
      error = "Issue title is required"
    }
    
    precondition ($input.team_key != null && $input.team_key != "") {
      error_type = "inputerror"
      error = "Team key is required (e.g., 'ENG', 'PROD')"
    }
    
    var $query { 
      value = "mutation IssueCreate($input: IssueCreateInput!) { issueCreate(input: $input) { success issue { id identifier title url state { name } } } }" 
    }
    
    var $variables {
      value = {
        input: {
          title: $input.title,
          description: $input.description,
          teamIdentifier: $input.team_key
        }
      }
    }
    
    var $payload {
      value = {
        query: $query,
        variables: $variables
      }
    }
    
    api.request {
      url = "https://api.linear.app/graphql"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: " ~ $api_key
      ]
      timeout = 30
    } as $api_result
    
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "Linear API request failed with status " ~ ($api_result.response.status|to_text)
    }
    
    var $response_data { value = $api_result.response.result }
    
    precondition ($response_data.errors == null) {
      error_type = "standard"
      error = "GraphQL error: " ~ ($response_data.errors|json_encode)
    }
    
    var $issue_create { value = $response_data.data.issueCreate }
    
    precondition ($issue_create.success == true) {
      error_type = "standard"
      error = "Failed to create issue"
    }
    
    var $issue { value = $issue_create.issue }
    
    var $result {
      value = {
        success: true,
        issue_id: $issue.id,
        identifier: $issue.identifier,
        title: $issue.title,
        url: $issue.url,
        state: $issue.state.name
      }
    }
  }
  response = $result
}
