function "pinecone_upsert" {
  description = "Upsert a vector to a Pinecone vector database index"
  input {
    text index_host { description = "Pinecone index host URL (e.g., https://my-index.svc.us-east1-gcp.pinecone.io)" }
    text vector_id { description = "Unique identifier for the vector" }
    vector vector_values { description = "The vector embedding values (array of floats)" }
    text? namespace="default" { description = "Optional namespace for the vector" }
    json? metadata { description = "Optional metadata object to attach to the vector" }
  }
  stack {
    var $upsert_payload {
      value = {
        vectors: [
          {
            id: $input.vector_id,
            values: $input.vector_values,
            metadata: $input.metadata ?? {}
          }
        ],
        namespace: $input.namespace ?? "default"
      }
    }

    api.request {
      url = $input.index_host ~ "/vectors/upsert"
      method = "POST"
      params = $upsert_payload
      headers = [
        "Content-Type: application/json",
        "Api-Key: " ~ $env.pinecone_api_key,
        "X-Pinecone-API-Version: 2024-07"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $result {
          value = {
            success: true,
            upsertedCount: $api_result.response.result.upsertedCount,
            message: "Vector upserted successfully to Pinecone"
          }
        }
      }
      else {
        throw {
          name = "PineconeAPIError"
          value = "Pinecone API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $result
}