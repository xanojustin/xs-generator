run.job "Toggl Start Timer" {
  main = {
    name: "start_time_entry"
    input: {
      workspace_id: "1234567"
      description: "Working on XanoScript project"
      billable: "false"
      project_id: ""
      tags: ""
    }
  }
  env = ["TOGGL_API_TOKEN", "TOGGL_EMAIL"]
}
