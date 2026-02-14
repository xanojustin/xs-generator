run.job "GitHub Create Issue" {
  main = {
    name: "create_github_issue"
    input: {
      owner: "octocat"
      repo: "Hello-World"
      title: "New issue created via XanoScript"
      body: "This issue was created automatically using the Xano Run Job framework.\n\n- Created at: {{now}}\n- Source: XanoScript run job"
      labels: "bug,automation"
    }
  }
  env = ["GITHUB_TOKEN"]
}
