function "index_document" {
  description = "Index a document into Meilisearch"
  input {
    text index_name filters=trim
    json document
  }
  stack {
    // Build the Meilisearch API URL
    var $url {
      value = $env.meilisearch_host ~ "/indexes/" ~ $input.index_name ~ "/documents"
    }

    // Make the API request to index the document
    api.request {
      url = $url
      method = "POST"
      params = $input.document
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.meilisearch_api_key
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    conditional {
      if ($api_result.response.status == 202) {
        // 202 Accepted is the success status for document indexing
        var $result {
          value = {
            success: true,
            task_uid: $api_result.response.result.taskUid,
            index_name: $input.index_name,
            message: "Document indexed successfully"
          }
        }
      }
      elseif ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $result {
          value = {
            success: true,
            status: $api_result.response.status,
            index_name: $input.index_name,
            message: "Document indexed"
          }
        }
      }
      else {
        var $result {
          value = {
            success: false,
            status: $api_result.response.status,
            error: $api_result.response.result|json_encode,
            message: "Failed to index document"
          }
        }
      }
    }
  }
  response = $result
}
