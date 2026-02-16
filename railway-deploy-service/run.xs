run.job "Railway Deploy Service" {
  main = {
    name: "deploy_railway_service"
    input: {
      project_id: "your-project-id"
      service_name: "my-new-service"
      image: "nginx:latest"
      env_vars: {
        PORT: "8080"
        ENV: "production"
      }
    }
  }
  env = ["railway_api_token"]
}
