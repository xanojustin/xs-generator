run.job "LaunchDarkly Toggle Feature Flag" {
  main = {
    name: "toggle_feature_flag"
    input: {
      flag_key: "new-dashboard-feature"
      environment_key: "production"
      enabled: true
    }
  }
  env = ["launchdarkly_api_key", "launchdarkly_project_key"]
}
