run.job "Jira Create Issue" {
  main = {
    name: "create_jira_issue"
    input: {
      project_key: "PROJ"
      summary: "Sample issue created via Xano Run Job"
      issue_type: "Task"
      description: "This is a sample issue created by the Xano Run Job."
      priority: "Medium"
    }
  }
  env = ["JIRA_BASE_URL", "JIRA_EMAIL", "JIRA_API_TOKEN"]
}
