function "geocode_address" {
  input {
    text address
  }
  stack {
    // Validate input
    precondition ($input.address != null && $input.address != "") {
      error_type = "inputerror"
      error = "Address is required"
    }

    // URL encode the address
    var $encoded_address { value = $input.address|url_encode }

    // Call Mapbox Geocoding API
    api.request {
      url = "https://api.mapbox.com/geocoding/v5/mapbox.places/" ~ $encoded_address ~ ".json"
      method = "GET"
      params = {
        access_token: $env.mapbox_access_token,
        limit: 1
      }
    } as $api_result

    // Check for successful response
    precondition ($api_result.response.status == 200) {
      error_type = "standard"
      error = "Mapbox API error: " ~ ($api_result.response.status|to_text)
    }

    var $data { value = $api_result.response.result }

    // Check if any features were found
    var $feature_count { value = $data.features|count }
    conditional {
      if ($feature_count == 0) {
        throw {
          name = "NotFoundError"
          value = "No location found for the provided address"
        }
      }
    }

    // Extract the first (best) result
    var $feature { value = $data.features|first }
    var $coordinates { value = $feature.geometry.coordinates }
    
    // Build response
    var $result {
      value = {
        query: $input.address,
        place_name: $feature.place_name,
        longitude: $coordinates|first,
        latitude: $coordinates|last,
        accuracy: $feature.properties.accuracy,
        place_type: $feature.place_type|first,
        relevance: $feature.relevance,
        address: $feature.address,
        text: $feature.text,
        context: $feature.context
      }
    }
  }
  response = $result
}
