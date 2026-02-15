function "publish_entry" {
  description = "Create and publish a content entry in Contentful CMS"
  input {
    text space_id filters=trim {
      description = "Contentful space ID"
    }
    text environment?="master" filters=trim {
      description = "Environment ID (default: master)"
    }
    text content_type filters=trim {
      description = "Content type ID (e.g., blogPost, article)"
    }
    text entry_id? filters=trim {
      description = "Optional entry ID to update existing entry (auto-generated if empty)"
    }
    object fields {
      description = "Entry fields with locale keys (e.g., {\"title\": {\"en-US\": \"Title\"}})"
    }
    bool publish?=true {
      description = "Whether to publish the entry immediately (default: true)"
    }
  }

  stack {
    // Get credentials from environment
    var $management_token {
      value = $env.CONTENTFUL_MANAGEMENT_TOKEN
    }
    var $default_space_id {
      value = $env.CONTENTFUL_SPACE_ID
    }

    // Use provided space_id or fall back to env var
    var $space_id {
      value = ($input.space_id != null && $input.space_id != "") ? $input.space_id : $default_space_id
    }

    // Validate management token is configured
    precondition ($management_token != null && $management_token != "") {
      error_type = "standard"
      error = "CONTENTFUL_MANAGEMENT_TOKEN environment variable not configured"
    }

    // Validate space ID is available
    precondition ($space_id != null && $space_id != "") {
      error_type = "standard"
      error = "Space ID is required (provide as input or set CONTENTFUL_SPACE_ID env var)"
    }

    // Validate content type is provided
    precondition ($input.content_type != null && $input.content_type != "") {
      error_type = "inputerror"
      error = "Content type is required"
    }

    // Validate fields are provided
    precondition ($input.fields != null) {
      error_type = "inputerror"
      error = "Fields object is required"
    }

    // Build the request payload
    var $payload {
      value = {
        fields: $input.fields
      }
    }

    // Determine if creating or updating
    var $is_update {
      value = ($input.entry_id != null && $input.entry_id != "")
    }

    // Build the API URL
    var $base_url {
      value = "https://api.contentful.com/spaces/" ~ $space_id ~ "/environments/" ~ $input.environment
    }

    // Construct the full URL based on create vs update
    var $api_url {
      value = $is_update ? ($base_url ~ "/entries/" ~ $input.entry_id) : ($base_url ~ "/entries")
    }

    // Set the HTTP method
    var $http_method {
      value = $is_update ? "PUT" : "POST"
    }

    // Send the request to Contentful
    api.request {
      url = $api_url
      method = $http_method
      params = $payload
      headers = [
        "Content-Type: application/vnd.contentful.management.v1+json",
        "Authorization: Bearer " ~ $management_token,
        "X-Contentful-Content-Type: " ~ $input.content_type
      ]
    } as $api_result

    // Initialize response variables
    var $success {
      value = false
    }
    var $entry_id {
      value = null
    }
    var $entry_version {
      value = null
    }
    var $published {
      value = false
    }
    var $error_message {
      value = null
    }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200 || $api_result.response.status == 201) {
        var $response_body {
          value = $api_result.response.result
        }
        var $success {
          value = true
        }
        var $entry_id {
          value = $response_body|get:"sys"|get:"id"
        }
        var $entry_version {
          value = $response_body|get:"sys"|get:"version"
        }

        // Publish the entry if requested
        conditional {
          if ($input.publish) {
            // Build publish URL
            var $publish_url {
              value = $base_url ~ "/entries/" ~ $entry_id ~ "/published"
            }

            // Send publish request
            api.request {
              url = $publish_url
              method = "PUT"
              headers = [
                "Content-Type: application/vnd.contentful.management.v1+json",
                "Authorization: Bearer " ~ $management_token,
                "X-Contentful-Version: " ~ ($entry_version|to_text)
              ]
            } as $publish_result

            conditional {
              if ($publish_result.response.status == 200) {
                var $published {
                  value = true
                }
              }
              else {
                var $published {
                  value = false
                }
                var $error_message {
                  value = "Entry created but publish failed: HTTP " ~ ($publish_result.response.status|to_text)
                }
              }
            }
          }
        }
      }
      else {
        var $success {
          value = false
        }
        var $error_message {
          value = "Contentful API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj {
              value = $api_result.response.result|get:"message"
            }
            conditional {
              if ($error_obj != null) {
                var $error_message {
                  value = $error_obj
                }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    entry_id: $entry_id,
    version: $entry_version,
    published: $published,
    error: $error_message
  }
}
