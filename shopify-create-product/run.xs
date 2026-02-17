run.job "Shopify Create Product" {
  main = {
    name: "shopify_create_product"
    input: {
      title: "Xano Test Product"
      body_html: "<p>This is a test product created via Xano Run Job</p>"
      vendor: "Xano Store"
      product_type: "Test Product"
      tags: ["xano", "test", "api"]
      price: "29.99"
      sku: "XANO-TEST-001"
      inventory_quantity: 100
    }
  }
  env = ["shopify_store_domain", "shopify_access_token"]
}
