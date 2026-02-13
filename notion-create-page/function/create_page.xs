function "create_page" {
  description = "Create a new page in a Notion database"
  input {
  }
  stack {
    // Get configuration from environment variables
    var $api_key {
      value = $env.notion_api_key
    }
    var $database_id {
      value = $env.notion_database_id
    }
    var $page_title {
      value = $env.notion_page_title
    }
    var $page_content {
      value = $env.notion_page_content
    }

    // Validate required fields - api_key
    conditional {
      if ($api_key == null) {
        var $result {
          value = {
            status: "error",
            message: "notion_api_key is required"
          }
        }
      }
    }

    // Validate database_id
    conditional {
      if ($database_id == null) {
        var $result {
          value = {
            status: "error",
            message: "notion_database_id is required"
          }
        }
      }
    }

    // Validate page_title
    conditional {
      if ($page_title == null) {
        var $result {
          value = {
            status: "error",
            message: "notion_page_title is required"
          }
        }
      }
    }

    // Check if we have all required fields before proceeding
    conditional {
      if ($api_key != null && $database_id != null && $page_title != null) {
        // Set default content if not provided
        var $content {
          value = ($page_content != null) ? $page_content : "Created via Xano Run Job"
        }

        // Build the page payload for Notion API
        var $page_payload {
          value = {
            parent: {
              database_id: $database_id
            },
            properties: {
              Name: {
                title: [
                  {
                    text: {
                      content: $page_title
                    }
                  }
                ]
              }
            },
            children: [
              {
                object: "block",
                type: "paragraph",
                paragraph: {
                  rich_text: [
                    {
                      type: "text",
                      text: {
                        content: $content
                      }
                    }
                  ]
                }
              }
            ]
          }
        }

        // Make the API request to Notion
        api.request {
          url = "https://api.notion.com/v1/pages"
          method = "POST"
          headers = [
            "Content-Type: application/json",
            "Notion-Version: 2022-06-28",
            "Authorization: Bearer " ~ $api_key
          ]
          params = $page_payload
          timeout = 30
        } as $api_result

        // Check if the request was successful
        var $http_status {
          value = ($api_result.response.status)
        }

        conditional {
          if ($http_status == 200) {
            // Page created successfully
            var $response_data {
              value = $api_result.response.result
            }
            var $status {
              value = "success"
            }
            var $message {
              value = "Page created successfully in Notion database"
            }
            var $result {
              value = {
                status: $status,
                message: $message,
                page_id: $response_data.id,
                page_url: $response_data.url,
                created_time: $response_data.created_time,
                notion_response: $response_data
              }
            }
          }
        }

        conditional {
          if ($http_status != 200) {
            // Handle error
            var $response_data {
              value = $api_result.response.result
            }
            var $status {
              value = "error"
            }
            var $status_text {
              value = ($api_result.response.status)|to_text
            }
            var $error_message {
              value = ($response_data.message != null) ? $response_data.message : "Unknown error"
            }
            var $result {
              value = {
                status: $status,
                message: "Failed to create page. Status: " ~ $status_text ~ ", Error: " ~ $error_message,
                notion_response: $response_data
              }
            }
          }
        }
      }
    }
  }
  response = $result
}