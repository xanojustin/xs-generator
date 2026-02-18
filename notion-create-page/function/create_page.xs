function "create_page" {
  description = "Create a page in a Notion database"
  input {
    text database_id filters=trim { description = "Notion database ID to create the page in" }
    text title filters=trim { description = "Page title" }
    text content?="" filters=trim { description = "Page content/body text" }
  }
  stack {
    var $database_id {
      value = $input.database_id ?? $env.NOTION_DATABASE_ID
    }

    precondition ($database_id != null && $database_id != "") {
      error_type = "inputerror"
      error = "Database ID is required"
    }

    precondition ($env.NOTION_API_KEY != null && $env.NOTION_API_KEY != "") {
      error_type = "standard"
      error = "NOTION_API_KEY environment variable is required"
    }

    var $page_payload {
      value = {
        parent: { database_id: $database_id },
        properties: {
          Name: {
            title: [
              { text: { content: $input.title } }
            ]
          }
        },
        children: [
          {
            object: "block",
            type: "paragraph",
            paragraph: {
              rich_text: [
                { type: "text", text: { content: $input.content } }
              ]
            }
          }
        ]
      }
    }

    api.request {
      url = "https://api.notion.com/v1/pages"
      method = "POST"
      params = $page_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.NOTION_API_KEY,
        "Notion-Version: 2022-06-28"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300 && $api_result.response.result.object == "page") {
        var $notion_response { value = $api_result.response.result }

        db.add page_log {
          data = {
            notion_page_id: $notion_response.id,
            database_id: $database_id,
            title: $input.title,
            content: $input.content,
            url: $notion_response.url,
            status: "created",
            created_at: now
          }
        } as $log_entry

        var $result {
          value = {
            success: true,
            page_id: $notion_response.id,
            url: $notion_response.url,
            log_id: $log_entry.id
          }
        }
      }
      else {
        var $error_message {
          value = "Notion API error: " ~ ($api_result.response.result.message|to_text)
        }

        db.add page_log {
          data = {
            database_id: $database_id,
            title: $input.title,
            content: $input.content,
            status: "failed",
            error_message: $error_message,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "NotionError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}
