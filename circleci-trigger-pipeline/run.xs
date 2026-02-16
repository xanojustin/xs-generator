run.job "Trigger CircleCI Pipeline" {
  main = {
    name: "trigger_pipeline"
    input: {
      project_slug: "gh/myorg/myrepo"
      branch: "main"
    }
  }
  env = ["circleci_api_token"]
}
