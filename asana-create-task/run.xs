run.job "Asana Create Task" {
  main = {
    name: "asana_create_task"
    input: {
      project_id: "1200000000000000"
      task_name: "New Task from Xano"
      task_notes: "This task was created automatically via the Xano Run Job.\n\n- Created by: XanoScript\n- Purpose: Project management automation"
      assignee_id: ""
      due_date: ""
      tags_json: "[]"
      priority: "normal"
    }
  }
  env = ["asana_personal_access_token"]
}