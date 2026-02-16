function "create_notion_page" {
  description = "Create a page in a Notion database using the Notion API"
  input {
    text database_id filters=trim
    text title filters=trim
    text? content
    json? properties
    text[]? tags
  }
  
  stack {
    precondition ($input.database_id != "") {
      error_type = "inputerror"
      error = "Notion database ID is required"
    }
    
    precondition ($input.title != "") {
      error_type = "inputerror"
      error = "Page title is required"
    }
    
    var $api_key { value = $env.NOTION_API_KEY }
    
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "NOTION_API_KEY environment variable is required"
    }
    
    var $notion_version { value = "2022-06-28" }
    
    var $title_block {
      value = {
        type: "title"
        title: [
          {
            type: "text"
            text: { content: $input.title }
          }
        ]
      }
    }
    
    var $page_properties {
      value = {
        Name: {
          title: [
            {
              text: { content: $input.title }
            }
          ]
        }
      }
    }
    
    conditional {
      if (($input.tags != null) && (($input.tags|count) > 0)) {
        var $tag_objects {
          value = $input.tags|map:{name: $$}
        }
        var.update $page_properties {
          value = $page_properties|set:"Tags":{multi_select: $tag_objects}
        }
      }
    }
    
    conditional {
      if (($input.properties != null) && (($input.properties|keys|count) > 0)) {
        var $custom_keys { value = $input.properties|keys }
        
        foreach ($custom_keys) {
          each as $key {
            var $value { value = $input.properties|get:$key }
            var.update $page_properties {
              value = $page_properties|set:$key:$value
            }
          }
        }
      }
    }
    
    var $children_blocks { value = [] }
    
    conditional {
      if (($input.content != null) && ($input.content != "")) {
        var $content_blocks {
          value = [
            {
              object: "block"
              type: "paragraph"
              paragraph: {
                rich_text: [
                  {
                    type: "text"
                    text: { content: $input.content }
                  }
                ]
              }
            }
          ]
        }
        var.update $children_blocks { value = $content_blocks }
      }
    }
    
    var $payload {
      value = {
        parent: { database_id: $input.database_id }
        properties: $page_properties
      }
    }
    
    conditional {
      if (($children_blocks|count) > 0) {
        var.update $payload { value = $payload|set:"children":$children_blocks }
      }
    }
    
    debug.log { value = "Creating Notion page in database: " ~ $input.database_id }
    
    api.request {
      url = "https://api.notion.com/v1/pages"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
        "Authorization: Bearer " ~ $api_key
        "Notion-Version: " ~ $notion_version
      ]
      timeout = 30
    } as $api_result
    
    debug.log { value = "Notion API response status: " ~ ($api_result.response.status|to_text) }
    
    conditional {
      if (($api_result.response.status >= 200) && ($api_result.response.status < 300)) {
        var $page_result {
          value = {
            success: true
            page_id: $api_result.response.result.id
            database_id: $input.database_id
            title: $input.title
            url: $api_result.response.result.url
            created_time: $api_result.response.result.created_time
          }
        }
      }
      else {
        var $error_message { value = "Unknown Notion API error" }
        
        conditional {
          if ($api_result.response.result|has:"message") {
            var.update $error_message {
              value = $api_result.response.result|get:"message"
            }
          }
        }
        
        throw {
          name = "NotionAPIError"
          value = "Notion API error (" ~ ($api_result.response.status|to_text) ~ "): " ~ $error_message
        }
      }
    }
  }
  
  response = $page_result
}
