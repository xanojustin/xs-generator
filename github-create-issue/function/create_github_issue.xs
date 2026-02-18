function "create_github_issue" {
  description = "Create an issue in a GitHub repository"
  input {
    text repo_owner filters=trim { description = "Repository owner (username or org)" }
    text repo_name filters=trim { description = "Repository name" }
    text title filters=trim { description = "Issue title" }
    text body?="" filters=trim { description = "Issue body/description" }
    text[] labels? { description = "Array of label names to apply" }
  }
  stack {
    var $payload {
      value = {
        title: $input.title,
        body: $input.body
      }
    }

    conditional {
      if ($input.labels != null && ($input.labels|count) > 0) {
        var.update $payload { value = $payload|set:"labels":$input.labels }
      }
    }

    var $api_url {
      value = "https://api.github.com/repos/" ~ $input.repo_owner ~ "/" ~ $input.repo_name ~ "/issues"
    }

    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.GITHUB_TOKEN,
        "Accept: application/vnd.github+json",
        "X-GitHub-Api-Version: 2022-11-28"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status == 201) {
        var $issue { value = $api_result.response.result }

        db.add issue_log {
          data = {
            repo_owner: $input.repo_owner,
            repo_name: $input.repo_name,
            issue_number: $issue.number,
            issue_title: $issue.title,
            issue_url: $issue.html_url,
            github_issue_id: $issue.id,
            created_at: now
          }
        } as $log_entry

        var $result {
          value = {
            success: true,
            issue_number: $issue.number,
            issue_title: $issue.title,
            issue_url: $issue.html_url,
            github_issue_id: $issue.id,
            log_id: $log_entry.id
          }
        }
      }
      else {
        var $error_message {
          value = "GitHub API error: " ~ ($api_result.response.result.message|to_text)
        }

        db.add issue_log {
          data = {
            repo_owner: $input.repo_owner,
            repo_name: $input.repo_name,
            issue_title: $input.title,
            status: "failed",
            error_message: $error_message,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "GitHubError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}
