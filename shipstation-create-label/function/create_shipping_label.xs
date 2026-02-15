// Creates a shipping label via ShipStation API
// Uses Basic Authentication with API Key and Secret
function "create_shipping_label" {
  description = "Creates a shipping label using the ShipStation API"
  
  input {
    text order_id
    text service_code
    text package_code
    int weight_oz
    object dimensions {
      schema {
        int length
        int width  
        int height
      }
    }
    text ship_to_name?
    text ship_to_street?
    text ship_to_city?
    text ship_to_state?
    text ship_to_postal_code?
    text ship_to_country?="US"
  }
  
  stack {
    // Validate required inputs
    precondition ($input.order_id != null && $input.order_id != "") {
      error_type = "inputerror"
      error = "Order ID is required"
    }
    
    precondition ($input.service_code != null && $input.service_code != "") {
      error_type = "inputerror"
      error = "Service code is required"
    }
    
    precondition ($input.weight_oz > 0) {
      error_type = "inputerror"
      error = "Weight must be greater than 0 ounces"
    }
    
    // Build the shipment payload
    var $payload {
      value = {
        orderId: $input.order_id,
        serviceCode: $input.service_code,
        packageCode: $input.package_code,
        weight: {
          value: $input.weight_oz,
          units: "ounces"
        },
        dimensions: {
          length: $input.dimensions.length,
          width: $input.dimensions.width,
          height: $input.dimensions.height,
          units: "inches"
        },
        shipDate: now|format_timestamp:"Y-m-d"
      }
    }
    
    // Add optional ship-to address if provided
    conditional {
      if ($input.ship_to_name != null) {
        var $ship_to {
          value = {
            name: $input.ship_to_name,
            street1: $input.ship_to_street,
            city: $input.ship_to_city,
            state: $input.ship_to_state,
            postalCode: $input.ship_to_postal_code,
            country: $input.ship_to_country
          }
        }
        var.update $payload {
          value = $payload|set:"shipTo":$ship_to
        }
      }
    }
    
    // Make API request to ShipStation
    api.request {
      url = $env.shipstation_base_url ~ "/shipments/createlabel"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ (($env.shipstation_api_key ~ ":" ~ $env.shipstation_api_secret)|base64_encode)
      ]
      timeout = 60
    } as $api_result
    
    // Handle API response
    conditional {
      if ($api_result.response.status == 200) {
        var $label_data { value = $api_result.response.result }
        
        var $result {
          value = {
            success: true,
            shipment_id: $label_data.shipmentId,
            tracking_number: $label_data.trackingNumber,
            label_data: $label_data.labelData,
            shipment_cost: $label_data.shipmentCost,
            insurance_cost: $label_data.insuranceCost,
            package_code: $label_data.packageCode,
            service_code: $label_data.serviceCode,
            ship_date: $label_data.shipDate,
            created_at: now
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        throw {
          name = "ValidationError"
          value = "Invalid request: " ~ ($api_result.response.result|json_encode)
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid API credentials"
        }
      }
      else {
        throw {
          name = "APIError"
          value = "ShipStation API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  
  response = $result
}
