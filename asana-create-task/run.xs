run.job "Asana Create Task" {
  main = {
    name: "asana_create_task"
    input: {
      name: "New Task from Xano"
      project_id: "1234567890"
      notes: "This task was created via Xano Run Job"
      assignee: ""
      due_date: ""
    }
  }
  env = ["asana_access_token"]
}
