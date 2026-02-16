function "trigger_pipeline" {
  description = "Trigger a CircleCI pipeline for a given project and branch"
  input {
    text project_slug filters=trim {
      description = "Project slug (e.g., gh/myorg/myrepo or bb/myorg/myrepo)"
    }
    text branch?="main" filters=trim {
      description = "Git branch to trigger pipeline on"
    }
    object parameters? {
      description = "Optional pipeline parameters"
    }
  }
  stack {
    // Handle branch default
    var $branch {
      value = "main"
    }
    conditional {
      if ($input.branch != null) {
        var.update $branch {
          value = $input.branch
        }
      }
    }

    // Build the request payload
    var $payload {
      value = {}|set:"branch": `$branch`
    }

    // Add parameters if provided
    conditional {
      if ($input.parameters != null) {
        var.update $payload {
          value = $payload|set:"parameters":$input.parameters
        }
      }
    }

    // Make the API request to CircleCI
    api.request {
      url = "https://circleci.com/api/v2/project/" ~ $input.project_slug ~ "/pipeline"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Circle-Token: " ~ $env.circleci_api_token
      ]
      timeout = 30
    } as $api_result

    // Validate response status
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "CircleCI API error: " ~ ($api_result.response.status|to_text)
    }

    // Extract pipeline details from response
    var $pipeline {
      value = $api_result.response.result
    }

    // Build success response
    var $result_data {
      value = {
        success: true,
        pipeline_id: $pipeline.id,
        pipeline_number: $pipeline.number,
        state: $pipeline.state,
        created_at: $pipeline.created_at,
        project_slug: $input.project_slug,
        branch: `$branch`
      }
    }
  }
  response = $result_data
}
