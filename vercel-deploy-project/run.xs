run.job "Vercel Deploy Project" {
  main = {
    name: "trigger_vercel_deployment"
    input: {
      project_id: ""
      team_id: ""
      target: "production"
    }
  }
  env = ["vercel_api_token"]
}
