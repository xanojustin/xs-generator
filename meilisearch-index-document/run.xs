run.job "Meilisearch Index Document" {
  main = {
    name: "index_document"
    input: {
      index_name: "products"
      document: {
        id: "prod_001"
        name: "Sample Product"
        description: "A sample product for demonstration"
        price: 29.99
        category: "electronics"
      }
    }
  }
  env = ["meilisearch_host", "meilisearch_api_key"]
}
