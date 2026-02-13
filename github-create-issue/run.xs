run.job "GitHub Create Issue" {
  main = {
    name: "create_issue"
    input: {}
  }
  env = ["github_token", "github_owner", "github_repo", "github_issue_title", "github_issue_body"]
}