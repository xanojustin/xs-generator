run.job "GitHub Create Issue" {
  main = {
    name: "github_create_issue"
    input: {
      repo_owner: "octocat"
      repo_name: "Hello-World"
      title: "Test Issue from Xano"
      body: "This issue was created automatically via the Xano Run Job.\n\n- Created by: XanoScript\n- Purpose: API integration testing"
      labels_json: "[\"bug\", \"automated\"]"
      assignees_json: "[]"
    }
  }
  env = ["github_token"]
}