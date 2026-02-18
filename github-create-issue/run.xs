run.job "GitHub Create Issue" {
  main = {
    name: "create_github_issue"
    input: {
      repo_owner: "octocat"
      repo_name: "Hello-World"
      title: "Found a bug"
      body: "I'm having a problem with this."
      labels: ["bug", "help wanted"]
    }
  }
  env = ["GITHUB_TOKEN"]
}
