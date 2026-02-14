run.job "Linear Create Issue" {
  main = {
    name: "create_linear_issue"
    input: {
      title: "New Issue from Xano"
      description: "This issue was created automatically by Xano Run Job."
      team_key: "TEAM_KEY"
    }
  }
  env = ["linear_api_key"]
}
