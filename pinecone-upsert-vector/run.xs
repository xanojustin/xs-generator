run.job "Pinecone Upsert Vector" {
  main = {
    name: "pinecone_upsert"
    input: {
      index_host: "https://my-index-12345.svc.us-east1-gcp.pinecone.io"
      vector_id: "user_123"
      vector_values: [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8]
      namespace: "default"
      metadata: { user_id: "123", category: "embedding" }
    }
  }
  env = ["pinecone_api_key"]
}