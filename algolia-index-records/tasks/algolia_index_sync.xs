task "algolia_index_sync" {
  description = "Sync unindexed product records from local database to Algolia search index. Runs daily at 2 AM UTC."
  
  stack {
    debug.log {
      value = "Starting Algolia index sync task"
      description = "Log task start"
    }

    var $current_time {
      value = now
      description = "Current timestamp for logging"
    }

    db.query "products" {
      description = "Fetch products that haven't been indexed to Algolia yet"
      where = $db.products.is_indexed == false || $db.products.is_indexed == null
      sort = {products.created_at: "asc"}
      return = {
        type: "list"
        paging: {
          page: 1
          per_page: 100
        }
      }
    } as $unindexed_products

    var $product_count {
      value = $unindexed_products|count
      description = "Count of products to index"
    }

    debug.log {
      value = "Found " ~ $product_count ~ " products to index"
      description = "Log count of unindexed products"
    }

    conditional {
      description = "Process if there are products to index"
      if ($product_count > 0) {
        var $indexed_count {
          value = 0
          description = "Track successfully indexed products"
        }

        var $failed_count {
          value = 0
          description = "Track failed indexing attempts"
        }

        foreach ($unindexed_products) {
          each as $product {
            try_catch {
              description = "Index product to Algolia"
              try {
                var $algolia_object {
                  value = {}
                    |set:"objectID":($product.id|to_text)
                    |set:"name":$product.name
                    |set:"description":$product.description
                    |set:"category":$product.category
                    |set:"price":$product.price
                    |set:"sku":$product.sku
                    |set:"tags":$product.tags
                    |set:"in_stock":$product.in_stock
                    |set:"created_at":$product.created_at
                  description = "Build Algolia record object"
                }

                api.request {
                  url = "https://" ~ $env.algolia_app_id ~ "-dsn.algolia.net/1/indexes/products"
                  method = "POST"
                  headers = [
                    "X-Algolia-Application-Id: " ~ $env.algolia_app_id,
                    "X-Algolia-API-Key: " ~ $env.algolia_api_key,
                    "Content-Type: application/json"
                  ]
                  params = $algolia_object
                  timeout = 30
                  description = "Send product to Algolia index"
                } as $algolia_response

                conditional {
                  description = "Check if Algolia request was successful"
                  if ($algolia_response.status_code >= 200 && $algolia_response.status_code < 300) {
                    db.edit "products" {
                      field_name = "id"
                      field_value = $product.id
                      data = {
                        is_indexed: true
                        indexed_at: $current_time
                        algolia_object_id: $algolia_response.response.result.objectID
                      }
                      description = "Mark product as indexed"
                    } as $updated_product

                    math.add $indexed_count {
                      value = 1
                      description = "Increment success counter"
                    }

                    debug.log {
                      value = "Successfully indexed product ID: " ~ $product.id
                      description = "Log successful indexing"
                    }
                  }
                  else {
                    math.add $failed_count {
                      value = 1
                      description = "Increment failure counter"
                    }

                    debug.log {
                      value = "Failed to index product ID: " ~ $product.id ~ " - Status: " ~ $algolia_response.status_code
                      description = "Log indexing failure"
                    }
                  }
                }
              }
              catch {
                math.add $failed_count {
                  value = 1
                  description = "Increment failure counter on exception"
                }

                debug.log {
                  value = "Exception indexing product ID: " ~ $product.id ~ " - Error: " ~ $error.message ~ " (Code: " ~ $error.code ~ ")"
                  description = "Log indexing exception"
                }
              }
            }
          }
        }

        debug.log {
          value = "Algolia sync completed - Indexed: " ~ $indexed_count ~ ", Failed: " ~ $failed_count
          description = "Log task completion summary"
        }
      }
      else {
        debug.log {
          value = "No products to index"
          description = "Log when no products need indexing"
        }
      }
    }

    debug.log {
      value = "Algolia index sync task finished"
      description = "Log task end"
    }
  }

  schedule = [{starts_on: 2026-02-13 02:00:00+0000, freq: 86400}]
  
  history = "inherit"
}
