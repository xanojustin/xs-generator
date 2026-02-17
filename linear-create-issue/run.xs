run.job "Linear Create Issue" {
  main = {
    name: "create_linear_issue"
    input: {
      title: "New Issue from Xano Run Job"
      description: "This issue was created automatically via the Xano Run Job."
      team_id: "team_id_placeholder"
    }
  }
  env = ["linear_api_key"]
}