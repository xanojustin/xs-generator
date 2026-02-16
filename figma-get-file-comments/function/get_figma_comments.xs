function "get_figma_comments" {
  input {
    text file_key
  }
  stack {
    precondition ($input.file_key != null && $input.file_key != "") {
      error_type = "inputerror"
      error = "File key is required"
    }

    precondition ($env.figma_token != null && $env.figma_token != "") {
      error_type = "inputerror"
      error = "Figma token is required. Set figma_token environment variable."
    }

    var $api_url {
      value = "https://api.figma.com/v1/files/" ~ $input.file_key ~ "/comments"
    }

    api.request {
      url = $api_url
      method = "GET"
      headers = [
        "X-Figma-Token: " ~ $env.figma_token
      ]
      timeout = 30
    } as $api_result

    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "Figma API error: " ~ ($api_result.response.status|to_text)
    }

    var $comments {
      value = $api_result.response.result.comments
    }

    var $file_name {
      value = $api_result.response.result.file_name
    }

    var $final_result {
      value = {
        file_name: $file_name,
        file_key: $input.file_key,
        comment_count: $comments|count,
        comments: $comments
      }
    }
  }
  response = $final_result
}
