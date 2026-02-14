run.job "GitLab Create Issue" {
  main = {
    name: "create_issue"
    input: {
      project_id: "12345678"
      title: "Bug: Application crashes on startup"
      description: "## Description\n\nThe application crashes when users try to start it.\n\n## Steps to Reproduce\n\n1. Open the app\n2. Click 'Start'\n3. Observe crash\n\n## Expected Behavior\n\nApp should start normally."
      labels: "bug,critical"
      assignee_id: ""
      milestone_id: ""
    }
  }
  env = ["GITLAB_TOKEN", "GITLAB_BASE_URL"]
}
