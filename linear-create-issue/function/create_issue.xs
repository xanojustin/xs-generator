function "create_linear_issue" {
  description = "Create a new issue in Linear using the GraphQL API"
  input {
    text title filters=trim { description = "The title of the issue to create" }
    text description filters=trim { description = "The description/body of the issue" }
    text team_id filters=trim { description = "The Linear team ID to create the issue in" }
  }
  stack {
    // Validate inputs
    precondition ($input.title != null && $input.title != "") {
      error_type = "inputerror"
      error = "Issue title is required"
    }
    
    precondition ($input.team_id != null && $input.team_id != "") {
      error_type = "inputerror"
      error = "Team ID is required. Find it in Linear Settings > Teams."
    }
    
    // Get API key from environment
    var $api_key { value = $env.linear_api_key }
    
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "Linear API key is not configured. Set linear_api_key environment variable."
    }
    
    // Build GraphQL mutation query string
    var $graphql_query {
      value = "mutation IssueCreate { issueCreate(input: { title: \"" ~ $input.title ~ "\" description: \"" ~ $input.description ~ "\" teamId: \"" ~ $input.team_id ~ "\" }) { success issue { id identifier title url } } }"
    }
    
    // Build request payload
    var $request_body {
      value = {
        query: $graphql_query
      }
    }
    
    // Make the API request to Linear
    api.request {
      url = "https://api.linear.app/graphql"
      method = "POST"
      params = $request_body
      headers = [
        "Authorization: " ~ $api_key,
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $linear_response
    
    // Check response status
    conditional {
      if ($linear_response.response.status == 200) {
        // Parse the GraphQL response
        var $response_data { value = $linear_response.response.result }
        
        // Check for GraphQL errors
        conditional {
          if ($response_data.errors != null) {
            var $error_message { 
              value = $response_data.errors[0].message ?? "Unknown GraphQL error"
            }
            throw {
              name = "LinearGraphQLError"
              value = "Linear API error: " ~ $error_message
            }
          }
          else {
            // Success - issue created
            var $issue_data { value = $response_data.data.issueCreate }
            
            conditional {
              if ($issue_data.success == true) {
                var $issue { value = $issue_data.issue }
                var $result {
                  value = {
                    success: true,
                    issue_id: $issue.id,
                    identifier: $issue.identifier,
                    title: $issue.title,
                    url: $issue.url,
                    message: "Issue created successfully in Linear"
                  }
                }
              }
              else {
                throw {
                  name = "LinearAPIError"
                  value = "Failed to create issue. Linear returned success: false"
                }
              }
            }
          }
        }
      }
      elseif ($linear_response.response.status == 401) {
        throw {
          name = "LinearAuthError"
          value = "Authentication failed. Check your Linear API key."
        }
      }
      elseif ($linear_response.response.status == 400) {
        throw {
          name = "LinearAPIError"
          value = "Bad request. Check your GraphQL query format or team ID."
        }
      }
      else {
        var $error_detail {
          value = $linear_response.response.result.errors[0].message ?? ("HTTP " ~ ($linear_response.response.status|to_text))
        }
        throw {
          name = "LinearAPIError"
          value = "Linear API error: " ~ $error_detail
        }
      }
    }
  }
  response = $result
}