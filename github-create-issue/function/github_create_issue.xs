function "github_create_issue" {
  description = "Create an issue in a GitHub repository using the GitHub REST API"
  input {
    text owner { description = "GitHub username or organization that owns the repository" }
    text repo { description = "Name of the repository" }
    text title { description = "Title of the issue" }
    text body { description = "Body content of the issue (supports Markdown)" }
    text[] labels { description = "Array of label names to apply to the issue" }
  }
  stack {
    var $payload {
      value = {
        title: $input.title,
        body: $input.body,
        labels: $input.labels
      }
    }

    api.request {
      url = "https://api.github.com/repos/" ~ $input.owner ~ "/" ~ $input.repo ~ "/issues"
      method = "POST"
      params = $payload
      headers = [
        "Authorization: Bearer " ~ $env.github_token,
        "Accept: application/vnd.github+json",
        "X-GitHub-Api-Version: 2022-11-28",
        "Content-Type: application/json",
        "User-Agent: Xano-Run-Job"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $issue { value = $api_result.response.result }
      }
      else {
        throw {
          name = "GitHubAPIError"
          value = "GitHub API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $issue
}