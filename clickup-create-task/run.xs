run.job "ClickUp Create Task" {
  main = {
    name: "create_clickup_task"
    input: {
      list_id: ""
      task_name: ""
      task_description: ""
      assignee_ids: []
      due_date: ""
      priority: 3
      tags: []
    }
  }
  env = ["clickup_api_key", "clickup_team_id"]
}
