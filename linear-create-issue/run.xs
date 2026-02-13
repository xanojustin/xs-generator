run.job "Linear Create Issue" {
  main = {
    name: "linear_create_issue"
    input: {
      title: "New feature request from run job"
      description: "This issue was created automatically via Xano Run Job"
    }
  }

  env = ["linear_api_key"]
}
