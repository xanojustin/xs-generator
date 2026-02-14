run.job "Jira Create Issue" {
  main = {
    name: "jira_create_issue"
    input: {
      project_key: "PROJ"
      summary: "New issue from Xano Run Job"
      description: "This issue was created automatically using XanoScript and the Xano Job Runner."
      issue_type: "Task"
    }
  }
  env = ["jira_base_url", "jira_api_token"]
}
