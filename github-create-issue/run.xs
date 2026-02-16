run.job "GitHub Create Issue" {
  main = {
    name: "github_create_issue"
    input: {
      owner: "octocat"
      repo: "Hello-World"
      title: "Test issue created from Xano Run Job"
      body: "This issue was created automatically using the Xano Run Job for the GitHub API."
      labels: ["bug", "automated"]
    }
  }
  env = ["github_token"]
}