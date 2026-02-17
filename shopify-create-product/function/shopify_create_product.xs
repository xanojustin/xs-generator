function "shopify_create_product" {
  description = "Create a product in Shopify using the Admin API"
  input {
    text title { description = "Product title" }
    text body_html { description = "Product description in HTML" }
    text vendor { description = "Product vendor/brand name" }
    text product_type { description = "Product type/category" }
    text[] tags { description = "Array of tags for the product" }
    text price { description = "Product price as a string (e.g., '29.99')" }
    text sku { description = "Stock keeping unit identifier" }
    int inventory_quantity { description = "Initial inventory quantity" }
  }
  stack {
    var $product_payload {
      value = {
        product: {
          title: $input.title,
          body_html: $input.body_html,
          vendor: $input.vendor,
          product_type: $input.product_type,
          tags: $input.tags|join:",",
          variants: [
            {
              price: $input.price,
              sku: $input.sku,
              inventory_quantity: $input.inventory_quantity,
              requires_shipping: true,
              taxable: true
            }
          ]
        }
      }
    }

    api.request {
      url = "https://" ~ $env.shopify_store_domain ~ ".myshopify.com/admin/api/2024-01/products.json"
      method = "POST"
      params = $product_payload
      headers = [
        "Content-Type: application/json",
        "X-Shopify-Access-Token: " ~ $env.shopify_access_token
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $product { value = $api_result.response.result }
      }
      else {
        throw {
          name = "ShopifyAPIError"
          value = "Shopify API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $product
}
