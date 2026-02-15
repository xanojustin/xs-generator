// ShipStation Create Shipping Label Run Job
// Creates a shipping label via the ShipStation API
run.job "ShipStation Create Shipping Label" {
  main = {
    name: "create_shipping_label"
    input: {
      order_id: "ORD-12345"
      service_code: "usps_priority"
      package_code: "package"
      weight_oz: 16
      dimensions: {
        length: 10
        width: 6
        height: 4
      }
    }
  }
  env = ["shipstation_api_key", "shipstation_api_secret", "shipstation_base_url"]
}
