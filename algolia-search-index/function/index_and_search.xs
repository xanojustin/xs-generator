function "index_and_search" {
  description = "Index sample products to Algolia and search the index using REST API"
  
  input {
    text index_name?="products" filters=trim {
      description = "Name of the Algolia index"
    }
    text search_query?="laptop" filters=trim {
      description = "Search query string"
    }
    int max_results?=10 filters=min:1|max:100 {
      description = "Maximum number of search results"
    }
  }
  
  stack {
    // Sample product data to index
    var $sample_products {
      value = [
        {
          objectID: "prod-001",
          name: "Wireless Bluetooth Headphones",
          description: "Premium noise-cancelling headphones with 30-hour battery",
          category: "Electronics",
          brand: "SoundMax",
          price: 199.99,
          rating: 4.5,
          in_stock: true,
          tags: ["audio", "wireless", "headphones"]
        },
        {
          objectID: "prod-002",
          name: "MacBook Pro 16-inch",
          description: "Apple M3 Pro chip, 18GB RAM, 512GB SSD",
          category: "Electronics",
          brand: "Apple",
          price: 2499.00,
          rating: 4.8,
          in_stock: true,
          tags: ["laptop", "apple", "pro"]
        },
        {
          objectID: "prod-003",
          name: "Ergonomic Office Chair",
          description: "Adjustable lumbar support and breathable mesh back",
          category: "Furniture",
          brand: "ComfortSeating",
          price: 349.99,
          rating: 4.3,
          in_stock: true,
          tags: ["chair", "office", "ergonomic"]
        },
        {
          objectID: "prod-004",
          name: "Mechanical Gaming Keyboard",
          description: "RGB backlit with Cherry MX switches",
          category: "Electronics",
          brand: "GamePro",
          price: 149.99,
          rating: 4.6,
          in_stock: false,
          tags: ["keyboard", "gaming", "rgb"]
        },
        {
          objectID: "prod-005",
          name: "Standing Desk Converter",
          description: "Adjustable height desk riser for home office",
          category: "Furniture",
          brand: "FlexiDesk",
          price: 279.99,
          rating: 4.4,
          in_stock: true,
          tags: ["desk", "standing", "office"]
        }
      ]
    }
    
    // Build batch request for Algolia
    var $batch_requests {
      value = $sample_products|map:{
        action: "addObject",
        body: $$
      }
    }
    
    var $batch_payload {
      value = {
        requests: $batch_requests
      }
    }
    
    // Index products to Algolia using batch API
    var $algolia_host {
      value = "https://" ~ $env.ALGOLIA_APP_ID ~ ".algolia.net"
    }
    
    api.request {
      url = $algolia_host ~ "/1/indexes/" ~ $input.index_name ~ "/batch"
      method = "POST"
      params = $batch_payload
      headers = [
        "Content-Type: application/json",
        "X-Algolia-API-Key: " ~ $env.ALGOLIA_API_KEY,
        "X-Algolia-Application-Id: " ~ $env.ALGOLIA_APP_ID
      ]
      timeout = 30
    } as $index_response
    
    // Check indexing success
    conditional {
      if ($index_response.response.status == 200) {
        debug.log { value = "Successfully indexed " ~ ($sample_products|count|to_text) ~ " products to Algolia" }
      }
      else {
        debug.log { value = "Indexing failed with status: " ~ ($index_response.response.status|to_text) }
      }
    }
    
    // Build search payload
    var $search_payload {
      value = {
        query: $input.search_query,
        hitsPerPage: $input.max_results,
        page: 0
      }
    }
    
    // Search the index
    api.request {
      url = $algolia_host ~ "/1/indexes/" ~ $input.index_name ~ "/query"
      method = "POST"
      params = $search_payload
      headers = [
        "Content-Type: application/json",
        "X-Algolia-API-Key: " ~ $env.ALGOLIA_SEARCH_KEY,
        "X-Algolia-Application-Id: " ~ $env.ALGOLIA_APP_ID
      ]
      timeout = 30
    } as $search_response
    
    // Parse search results
    var $search_result { value = $search_response.response.result }
    
    // Prepare the result data
    var $result_data {
      value = {
        indexed_count: $sample_products|count,
        index_name: $input.index_name,
        search_query: $input.search_query,
        index_status: $index_response.response.status,
        search_results: {
          hits: $search_result.hits,
          total_hits: $search_result.nbHits,
          page: $search_result.page,
          total_pages: $search_result.nbPages,
          processing_time_ms: $search_result.processingTimeMS
        }
      }
    }
  }
  
  response = $result_data
}
