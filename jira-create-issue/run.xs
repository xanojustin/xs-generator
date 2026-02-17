run.job "Jira Create Issue" {
  main = {
    name: "create_jira_issue"
    input: {
      project_key: "PROJ"
      summary: "Issue created via Xano Run Job"
      issue_type: "Task"
      description: ""
      priority: "Medium"
      assignee: ""
    }
  }
  env = ["JIRA_BASE_URL", "JIRA_API_TOKEN", "JIRA_USER_EMAIL"]
}
