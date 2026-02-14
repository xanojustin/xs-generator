run.job "Shopify Create Product" {
  main = {
    name: "create_product"
    input: {
      title: "New Product from Xano"
      product_type: "Electronics"
      vendor: "Xano Store"
      price: "29.99"
      inventory_quantity: 10
      tags: "xano,api,automation"
    }
  }
  env = ["SHOPIFY_SHOP_DOMAIN", "SHOPIFY_ACCESS_TOKEN"]
}
