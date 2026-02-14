function "create_product" {
  description = "Create a product in Shopify store using the Shopify Admin API"
  input {
    text title filters=trim { description = "Product title (required)" }
    text product_type?="" filters=trim { description = "Product type/category (optional)" }
    text vendor?="" filters=trim { description = "Product vendor/brand (optional)" }
    text price filters=trim { description = "Product price (e.g., '29.99')" }
    int inventory_quantity?=0 filters=min:0 { description = "Initial inventory quantity (default: 0)" }
    text tags?="" filters=trim { description = "Comma-separated product tags (optional)" }
    text description_html?="" filters=trim { description = "Product description in HTML (optional)" }
    bool published?=true { description = "Whether the product should be published (default: true)" }
  }

  stack {
    // Get environment variables
    var $shop_domain { value = $env.SHOPIFY_SHOP_DOMAIN }
    var $access_token { value = $env.SHOPIFY_ACCESS_TOKEN }

    // Validate shop domain is configured
    precondition ($shop_domain != null && $shop_domain != "") {
      error_type = "standard"
      error = "SHOPIFY_SHOP_DOMAIN environment variable not configured"
    }

    // Validate access token is configured
    precondition ($access_token != null && $access_token != "") {
      error_type = "standard"
      error = "SHOPIFY_ACCESS_TOKEN environment variable not configured"
    }

    // Validate title is provided
    precondition ($input.title != null && $input.title != "") {
      error_type = "inputerror"
      error = "Product title is required"
    }

    // Validate price is provided
    precondition ($input.price != null && $input.price != "") {
      error_type = "inputerror"
      error = "Product price is required"
    }

    // Build the product payload
    var $product_payload {
      value = {
        product: {
          title: $input.title,
          product_type: $input.product_type,
          vendor: $input.vendor,
          body_html: $input.description_html,
          tags: $input.tags,
          published: $input.published,
          variants: [
            {
              price: $input.price,
              inventory_quantity: $input.inventory_quantity,
              inventory_management: "shopify",
              requires_shipping: true,
              taxable: true
            }
          ]
        }
      }
    }

    // Construct the Shopify API URL
    var $api_url { value = "https://" ~ $shop_domain ~ ".myshopify.com/admin/api/2024-01/products.json" }

    // Send the request to Shopify
    api.request {
      url = $api_url
      method = "POST"
      params = $product_payload
      headers = [
        "Content-Type: application/json",
        "X-Shopify-Access-Token: " ~ $access_token
      ]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $product_id { value = null }
    var $product_handle { value = null }
    var $error_message { value = null }
    var $created_product { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $created_product { value = $response_body|get:"product" }
        var $success { value = true }
        var $product_id {
          value = $created_product|get:"id"|to_text
        }
        var $product_handle {
          value = $created_product|get:"handle"
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Shopify API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $errors { value = $api_result.response.result|get:"errors" }
            conditional {
              if ($errors != null) {
                var $error_message {
                  value = $errors|to_text
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
    product_id: $product_id,
    handle: $product_handle,
    product: $created_product,
    error: $error_message
  }
}
