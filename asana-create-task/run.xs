run.job "Asana Create Task" {
  main = {
    name: "create_asana_task"
    input: {
      name: "New Task from Xano"
      project_id: "your_project_id_here"
      notes: "This task was created via XanoScript Run Job"
    }
  }
  env = ["ASANA_ACCESS_TOKEN"]
}
