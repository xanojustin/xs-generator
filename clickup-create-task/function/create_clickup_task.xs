function "create_clickup_task" {
  input {
    text list_id
    text task_name
    text task_description?
    json assignee_ids?
    text due_date?
    int priority? = 3
    json tags?
  }
  stack {
    precondition ($input.list_id != "") {
      error_type = "inputerror"
      error = "list_id is required"
    }

    precondition ($input.task_name != "") {
      error_type = "inputerror"
      error = "task_name is required"
    }

    var $api_key {
      value = $env.clickup_api_key
    }

    var $assignees {
      value = ($input.assignee_ids ?? [])
    }

    var $task_tags {
      value = ($input.tags ?? [])
    }

    var $payload {
      value = {
        name: $input.task_name,
        description: ($input.task_description ?? ""),
        assignees: $assignees,
        priority: ($input.priority ?? 3)
      }
    }

    conditional {
      if ($input.due_date != null && $input.due_date != "") {
        var $due_date_ms {
          value = $input.due_date|to_ms
        }
        var $payload {
          value = ($payload|set:"due_date":$due_date_ms)
        }
      }
    }

    conditional {
      if (($task_tags|count) > 0) {
        var $payload {
          value = ($payload|set:"tags":$task_tags)
        }
      }
    }

    var $url {
      value = "https://api.clickup.com/api/v2/list/" ~ $input.list_id ~ "/task"
    }

    api.request {
      url = $url
      method = "POST"
      params = $payload
      headers = [
        "Authorization: " ~ $api_key,
        "Content-Type: application/json"
      ]
    } as $api_result

    conditional {
      if ($api_result.response.status != 200) {
        throw {
          name = "ClickUpAPIError"
          value = "Failed to create task: " ~ ($api_result.response.result|json_encode)
        }
      }
    }

    var $task_id {
      value = $api_result.response.result.id
    }

    var $result {
      value = {
        success: true,
        task_id: $task_id,
        task_name: $input.task_name,
        url: $api_result.response.result.url,
        created_at: now
      }
    }
  }
  response = $result
}
