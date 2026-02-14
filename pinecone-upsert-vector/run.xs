run.job "Pinecone Upsert Vector" {
  main = {
    name: "upsert_vector"
    input: {
      index_name: "my-index"
      id: "vec-001"
      values: [0.1, 0.2, 0.3, 0.4, 0.5]
      namespace: "default"
      metadata: {
        source: "example"
        category: "test"
      }
    }
  }
  env = ["PINECONE_API_KEY", "PINECONE_ENVIRONMENT"]
}
