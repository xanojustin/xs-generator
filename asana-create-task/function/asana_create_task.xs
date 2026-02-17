function "asana_create_task" {
  description = "Create a new task in an Asana project"
  input {
    text name { description = "Task name/title" }
    text project_id { description = "Asana project GID (required)" }
    text notes { description = "Task description/notes" }
    text assignee { description = "Assignee user GID (optional)" }
    text due_date { description = "Due date in YYYY-MM-DD format (optional)" }
  }
  stack {
    var $task_data {
      value = {
        data: {
          name: $input.name,
          projects: [$input.project_id],
          notes: $input.notes
        }
      }
    }

    conditional {
      if (($input.assignee|strlen) > 0) {
        var $task_data {
          value = {
            data: {
              name: $input.name,
              projects: [$input.project_id],
              notes: $input.notes,
              assignee: $input.assignee
            }
          }
        }
      }
    }

    conditional {
      if (($input.due_date|strlen) > 0) {
        var $task_data {
          value = {
            data: {
              name: $input.name,
              projects: [$input.project_id],
              notes: $input.notes,
              assignee: (($input.assignee|strlen) > 0) ? $input.assignee : null,
              due_on: $input.due_date
            }
          }
        }
      }
    }

    api.request {
      url = "https://app.asana.com/api/1.0/tasks"
      method = "POST"
      params = $task_data
      headers = [
        "Authorization: Bearer " ~ $env.asana_access_token,
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $task { value = $api_result.response.result.data }
      }
      else {
        throw {
          name = "AsanaAPIError"
          value = "Asana API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $task
}
