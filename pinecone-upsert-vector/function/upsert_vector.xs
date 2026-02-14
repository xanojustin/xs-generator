function "upsert_vector" {
  description = "Upsert a vector into a Pinecone index"
  input {
    text index_name filters=trim {
      description = "Name of the Pinecone index"
    }
    text id filters=trim {
      description = "Unique ID for the vector"
    }
    json values {
      description = "Vector values (array of floats)"
    }
    text namespace? filters=trim {
      description = "Namespace within the index (optional)"
    }
    json metadata? {
      description = "Metadata to attach to the vector (optional)"
    }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.PINECONE_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "PINECONE_API_KEY environment variable not configured"
    }

    // Validate index_name is provided
    precondition ($input.index_name != null && $input.index_name != "") {
      error_type = "inputerror"
      error = "Index name is required"
    }

    // Validate id is provided
    precondition ($input.id != null && $input.id != "") {
      error_type = "inputerror"
      error = "Vector ID is required"
    }

    // Validate values is provided and is a list
    precondition ($input.values != null && ($input.values|count) > 0) {
      error_type = "inputerror"
      error = "Vector values are required and must not be empty"
    }

    // Build the request URL
    var $base_url {
      value = "https://" ~ $input.index_name ~ "-" ~ $env.PINECONE_ENVIRONMENT ~ ".svc.pinecone.io"
    }

    // Build the vectors array
    var $vector_item {
      value = {
        id: $input.id,
        values: $input.values
      }
    }

    // Add metadata if provided
    conditional {
      if ($input.metadata != null) {
        var.update $vector_item {
          value = $vector_item|set:"metadata":$input.metadata
        }
      }
    }

    // Build the payload
    var $payload {
      value = {
        vectors: [$vector_item]
      }
    }

    // Add namespace if provided
    conditional {
      if ($input.namespace != null && $input.namespace != "") {
        var.update $payload {
          value = $payload|set:"namespace":$input.namespace
        }
      }
    }

    // Send the request to Pinecone
    api.request {
      url = $base_url ~ "/vectors/upsert"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Api-Key: " ~ $api_key
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $upserted_count { value = 0 }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $count_value { value = $response_body|get:"upsertedCount" }
        conditional {
          if ($count_value != null) {
            var $upserted_count { value = $count_value }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_body { value = $api_result.response.result }
        conditional {
          if ($error_body != null) {
            var $error_msg { value = $error_body|get:"message" }
            var $error_detail { value = $error_body|get:"detail" }
            conditional {
              if ($error_msg != null) {
                var $error_message { value = $error_msg }
              }
              elseif ($error_detail != null) {
                var $error_message { value = $error_detail }
              }
              else {
                var $error_message {
                  value = "Pinecone API error: HTTP " ~ ($api_result.response.status|to_text)
                }
              }
            }
          }
          else {
            var $error_message {
              value = "Pinecone API error: HTTP " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    upserted_count: $upserted_count,
    vector_id: $input.id,
    index_name: $input.index_name,
    error: $error_message
  }
}
