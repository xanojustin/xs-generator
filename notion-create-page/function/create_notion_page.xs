function "create_notion_page" {
  description = "Create a new page in a Notion database using the Notion API"
  input {
    text database_id filters=trim
    text title filters=trim
    text? content
    json? properties
  }
  stack {
    // Validate required environment variable
    precondition ($env.notion_api_key != null && $env.notion_api_key != "") {
      error_type = "standard"
      error = "NOTION_API_KEY environment variable is required"
    }

    // Validate required inputs
    precondition ($input.database_id != null && $input.database_id != "") {
      error_type = "inputerror"
      error = "database_id is required"
    }

    precondition ($input.title != null && $input.title != "") {
      error_type = "inputerror"
      error = "title is required"
    }

    // Build the page properties with title
    var $page_properties {
      value = {
        "Name": {
          "title": [
            { "text": { "content": $input.title } }
          ]
        }
      }
    }

    // Build the page content blocks
    var $children {
      value = []
    }

    // Add paragraph content if provided
    conditional {
      if ($input.content != null && $input.content != "") {
        var $children {
          value = [
            {
              "object": "block",
              "type": "paragraph",
              "paragraph": {
                "rich_text": [
                  { "type": "text", "text": { "content": $input.content } }
                ]
              }
            }
          ]
        }
      }
    }

    // Build the request payload
    var $payload {
      value = {
        "parent": { "database_id": $input.database_id },
        "properties": $page_properties
      }
    }

    // Add children (content blocks) if any exist
    conditional {
      if (($children|count) > 0) {
        var.update $payload {
          value = $payload|set:"children":$children
        }
      }
    }

    // Merge custom properties if provided
    conditional {
      if ($input.properties != null) {
        var $merged_properties {
          value = $page_properties|merge:$input.properties
        }
        var.update $payload {
          value = $payload|set:"properties":$merged_properties
        }
      }
    }

    // Send request to Notion API
    api.request {
      url = "https://api.notion.com/v1/pages"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.notion_api_key,
        "Notion-Version: 2022-06-28"
      ]
      timeout = 30
    } as $api_result

    // Handle response
    conditional {
      if ($api_result.response.status == 200 || $api_result.response.status == 201) {
        var $result {
          value = {
            success: true,
            page_id: $api_result.response.result.id,
            url: $api_result.response.result.url,
            title: $input.title,
            created_at: $api_result.response.result.created_time
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        var $error_message {
          value = ($api_result.response.result.message|first_notnull:"Bad request - check your database_id and properties")
        }
        var $result {
          value = {
            success: false,
            error: $error_message,
            status_code: $api_result.response.status
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        var $result {
          value = {
            success: false,
            error: "Unauthorized - check your Notion API key",
            status_code: $api_result.response.status
          }
        }
      }
      elseif ($api_result.response.status == 404) {
        var $result {
          value = {
            success: false,
            error: "Database not found - check your database_id",
            status_code: $api_result.response.status
          }
        }
      }
      else {
        var $error_message {
          value = ($api_result.response.result.message|first_notnull:"Unknown error")
        }
        var $result {
          value = {
            success: false,
            error: $error_message,
            status_code: $api_result.response.status
          }
        }
      }
    }
  }
  response = $result
}
