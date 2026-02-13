function "notion/create_page" {
  description = "Create a new page in a Notion database using the Notion API"

  input {
    text database_id filters=trim {
      description = "The Notion database ID to create the page in"
    }

    text title filters=trim|min:1 {
      description = "The title of the page"
    }

    text? content? {
      description = "Optional page content/body text"
    }

    text? status? {
      description = "Optional status property value (e.g., 'Not started', 'In progress', 'Done')"
    }

    text? priority? {
      description = "Optional priority property value (e.g., 'Low', 'Medium', 'High')"
    }

    text? tags? {
      description = "Optional comma-separated tags"
    }
  }

  stack {
    var $notion_api_key {
      value = $env.notion_api_key
      description = "Get Notion API key from environment"
    }

    precondition (($notion_api_key|strlen) > 0) {
      error_type = "standard"
      error = "notion_api_key environment variable is required"
    }

    var $properties {
      value = {}
      description = "Initialize properties object"
    }

    var $title_property {
      value = {
        title: [
          {
            text: {
              content: $input.title
            }
          }
        ]
      }
      description = "Build title property for Notion"
    }

    var.update $properties {
      value = $properties|set:"Name":$title_property
      description = "Add title to properties"
    }

    conditional {
      description = "Add status if provided"
      if ($input.status != "" && $input.status != null) {
        var $status_property {
          value = {
            select: {
              name: $input.status
            }
          }
          description = "Build status property"
        }

        var.update $properties {
          value = $properties|set:"Status":$status_property
          description = "Add status to properties"
        }
      }
    }

    conditional {
      description = "Add priority if provided"
      if ($input.priority != "" && $input.priority != null) {
        var $priority_property {
          value = {
            select: {
              name: $input.priority
            }
          }
          description = "Build priority property"
        }

        var.update $properties {
          value = $properties|set:"Priority":$priority_property
          description = "Add priority to properties"
        }
      }
    }

    conditional {
      description = "Add tags if provided"
      if ($input.tags != "" && $input.tags != null) {
        var $tags_array {
          value = $input.tags|split:","
          description = "Split tags by comma"
        }

        var $tags_property {
          value = {}
          description = "Initialize tags property"
        }

        var $multi_select_array {
          value = []
          description = "Array for multi-select items"
        }

        foreach ($tags_array) {
          each as $tag {
            var $trimmed_tag {
              value = $tag|trim
              description = "Trim whitespace from tag"
            }

            conditional {
              description = "Skip empty tags"
              if (($trimmed_tag|strlen) > 0) {
                var $tag_object {
                  value = {name: $trimmed_tag}
                  description = "Create tag object"
                }

                array.push $multi_select_array {
                  value = $tag_object
                  description = "Add tag to multi-select"
                }
              }
            }
          }
        }

        var.update $tags_property {
          value = {multi_select: $multi_select_array}
          description = "Build tags property with multi-select"
        }

        var.update $properties {
          value = $properties|set:"Tags":$tags_property
          description = "Add tags to properties"
        }
      }
    }

    var $request_body {
      value = {
        parent: {database_id: $input.database_id}
        properties: $properties
      }
      description = "Build request body for Notion API"
    }

    conditional {
      description = "Add content block if provided"
      if ($input.content != "" && $input.content != null) {
        var $children {
          value = [
            {
              object: "block"
              type: "paragraph"
              paragraph: {
                rich_text: [
                  {
                    type: "text"
                    text: {
                      content: $input.content
                    }
                  }
                ]
              }
            }
          ]
          description = "Build content children blocks"
        }

        var.update $request_body {
          value = $request_body|set:"children":$children
          description = "Add children content to request"
        }
      }
    }

    var $api_response {
      value = null
      description = "Initialize API response"
    }

    try_catch {
      description = "Call Notion API to create page"
      try {
        api.request {
          url = "https://api.notion.com/v1/pages"
          method = "POST"
          params = $request_body
          headers = []|push:"Authorization: Bearer " ~ $notion_api_key|push:"Content-Type: application/json"|push:"Notion-Version: 2022-06-28"
          timeout = 30
          description = "Create page in Notion database"
        } as $api_response

        debug.log {
          value = "Notion page created successfully: " ~ ($api_response|get:"id":null)
          description = "Log successful page creation"
        }
      }

      catch {
        debug.log {
          value = "Notion API error: " ~ $error.message
          description = "Log API error"
        }

        throw {
          name = "NotionAPIError"
          value = "Failed to create Notion page: " ~ $error.message
        }
      }
    }

    var $result {
      value = {
        success: true
        page_id: $api_response|get:"id":null
        url: $api_response|get:"url":null
        created_time: $api_response|get:"created_time":null
        title: $input.title
      }
      description = "Build success result"
    }
  }

  response = $result
}
