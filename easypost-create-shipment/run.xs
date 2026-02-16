run.job "EasyPost Create Shipment" {
  main = {
    name: "create_shipment"
    input: {
      to_address_name: "John Doe"
      to_address_street1: "123 Main Street"
      to_address_city: "San Francisco"
      to_address_state: "CA"
      to_address_zip: "94105"
      to_address_country: "US"
      from_address_name: "Acme Corp"
      from_address_street1: "456 Market Street"
      from_address_city: "San Francisco"
      from_address_state: "CA"
      from_address_zip: "94103"
      parcel_weight: "16"
      parcel_length: "10"
      parcel_width: "8"
      parcel_height: "6"
    }
  }
  env = ["EASYPOST_API_KEY"]
}
