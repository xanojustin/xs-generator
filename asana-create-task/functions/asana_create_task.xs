function "asana_create_task" {
  description = "Create a new task in an Asana project via the Asana API"

  input {
    text project_id filters=trim {
      description = "The Asana project ID (GID) where the task will be created"
    }

    text task_name filters=trim {
      description = "The name/title of the task"
    }

    text task_notes? filters=trim {
      description = "Optional notes/description for the task"
    }

    text assignee_id? filters=trim {
      description = "Optional Asana user ID (GID) to assign the task to"
    }

    text due_date? filters=trim {
      description = "Optional due date in YYYY-MM-DD format"
    }

    text tags_json? filters=trim {
      description = "Optional JSON array of tag GIDs to apply to the task"
    }

    text priority? filters=trim|lower {
      description = "Optional priority level (low, normal, high, urgent)"
    }
  }

  stack {
    precondition (($env.asana_personal_access_token|strlen) > 0) {
      error_type = "standard"
      error = "asana_personal_access_token environment variable is required"
    }

    precondition (($input.project_id|is_empty) == false) {
      error_type = "inputerror"
      error = "Asana project ID is required"
    }

    precondition (($input.task_name|is_empty) == false) {
      error_type = "inputerror"
      error = "Task name is required"
    }

    var $task_body {
      description = "Build the Asana API request payload"
      value = {
        data: {
          name: $input.task_name,
          projects: [$input.project_id]
        }
      }
    }

    conditional {
      description = "Add notes if provided"
      if (($input.task_notes|is_empty) == false) {
        var $task_data {
          value = $task_body.data|set:"notes":$input.task_notes
        }
        var $task_body {
          value = $task_body|set:"data":$task_data
        }
      }
    }

    conditional {
      description = "Add assignee if provided"
      if (($input.assignee_id|is_empty) == false) {
        var $task_data {
          value = $task_body.data|set:"assignee":$input.assignee_id
        }
        var $task_body {
          value = $task_body|set:"data":$task_data
        }
      }
    }

    conditional {
      description = "Add due date if provided"
      if (($input.due_date|is_empty) == false) {
        var $task_data {
          value = $task_body.data|set:"due_on":$input.due_date
        }
        var $task_body {
          value = $task_body|set:"data":$task_data
        }
      }
    }

    conditional {
      description = "Parse and add tags if provided"
      if (($input.tags_json|is_empty) == false) {
        var $tags {
          value = $input.tags_json|json_decode
        }
        var $task_data {
          value = $task_body.data|set:"tags":$tags
        }
        var $task_body {
          value = $task_body|set:"data":$task_data
        }
      }
    }

    conditional {
      description = "Add priority as a tag if specified (using Asana's priority tags)"
      if (($input.priority|is_empty) == false) {
        var $priority_value {
          value = $input.priority
        }
        var $task_data {
          value = $task_body.data|set:"custom_fields":{
            priority: $priority_value
          }
        }
        var $task_body {
          value = $task_body|set:"data":$task_data
        }
      }
    }

    api.request {
      description = "Make the Asana API call to create the task"
      url = "https://app.asana.com/api/1.0/tasks"
      method = "POST"
      headers = [
        "Authorization: Bearer " ~ $env.asana_personal_access_token,
        "Content-Type: application/json",
        "Accept: application/json"
      ]
      params = $task_body
    } as $asana_response

    var $response_status {
      description = "Extract HTTP status code"
      value = $asana_response.response.status
    }

    precondition ($response_status == 201) {
      error_type = "standard"
      error = "Asana API error (" ~ ($response_status|to_text) ~ "): " ~ ($asana_response.response.body.errors[0].message ?? "Unknown error")
    }

    var $task_data {
      description = "Extract task data from response"
      value = $asana_response.response.body.data
    }

    var $result {
      description = "Build the response object"
      value = {
        success: true,
        task_id: $task_data.gid,
        task_name: $task_data.name,
        task_url: "https://app.asana.com/0/" ~ $input.project_id ~ "/" ~ $task_data.gid,
        project_id: $input.project_id,
        assignee_id: $task_data.assignee.gid ?? null,
        due_date: $task_data.due_on ?? null,
        created_at: $task_data.created_at
      }
    }
  }

  response = $result
}