function "purge_cache" {
  description = "Purge Cloudflare CDN cache by URL(s) or cache tags"
  input {
    text zone_id filters=trim {
      description = "Cloudflare Zone ID (found in domain overview)"
    }
    object urls? {
      description = "Array of URLs to purge (optional)"
    }
    object tags? {
      description = "Array of cache tags to purge (optional, requires Enterprise plan)"
    }
    bool purge_everything?=false {
      description = "Set to true to purge entire cache (use with caution!)"
    }
  }

  stack {
    var $api_token {
      value = $env.CLOUDFLARE_API_TOKEN
    }

    precondition ($api_token != null && $api_token != "") {
      error_type = "standard"
      error = "CLOUDFLARE_API_TOKEN environment variable not configured"
    }

    precondition ($input.zone_id != null && $input.zone_id != "") {
      error_type = "inputerror"
      error = "Zone ID is required"
    }

    var $has_urls {
      value = $input.urls != null && ($input.urls|count) > 0
    }
    var $has_tags {
      value = $input.tags != null && ($input.tags|count) > 0
    }
    var $has_purge_all {
      value = $input.purge_everything == true
    }

    precondition ($has_urls || $has_tags || $has_purge_all) {
      error_type = "inputerror"
      error = "Must specify at least one of: urls, tags, or purge_everything"
    }

    var $payload {
      value = {}
    }

    conditional {
      if ($has_purge_all) {
        var.update $payload {
          value = { purge_everything: true }
        }
      }
      elseif ($has_urls) {
        var.update $payload {
          value = { files: $input.urls }
        }
      }
      elseif ($has_tags) {
        var.update $payload {
          value = { tags: $input.tags }
        }
      }
    }

    api.request {
      url = "https://api.cloudflare.com/client/v4/zones/" ~ $input.zone_id ~ "/purge_cache"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_token
      ]
    } as $api_result

    var $success {
      value = false
    }
    var $result_data {
      value = null
    }
    var $errors {
      value = null
    }
    var $messages {
      value = null
    }
    var $error_message {
      value = null
    }

    conditional {
      if ($api_result.response.status == 200) {
        var $response_body {
          value = $api_result.response.result
        }
        var $success_flag {
          value = $response_body|get:"success"
        }
        var $success {
          value = $success_flag == true
        }
        var $result_data {
          value = $response_body|get:"result"
        }
        var $errors {
          value = $response_body|get:"errors"
        }
        var $messages {
          value = $response_body|get:"messages"
        }
      }
      else {
        var $success {
          value = false
        }
        var $response_body {
          value = $api_result.response.result
        }
        conditional {
          if ($response_body != null) {
            var $errors {
              value = $response_body|get:"errors"
            }
            conditional {
              if ($errors != null && ($errors|count) > 0) {
                var $first_error {
                  value = $errors|first
                }
                var $error_message {
                  value = $first_error|get:"message"
                }
              }
              else {
                var $error_message {
                  value = "Cloudflare API error: HTTP " ~ ($api_result.response.status|to_text)
                }
              }
            }
          }
          else {
            var $error_message {
              value = "Cloudflare API error: HTTP " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    result: $result_data,
    errors: $errors,
    messages: $messages,
    error_message: $error_message
  }
}
