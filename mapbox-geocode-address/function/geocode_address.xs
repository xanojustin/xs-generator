function "geocode_address" {
  input {
    text address
    text country?=""
  }
  stack {
    // Build the API URL with query parameters
    var $encoded_address { value = $input.address|url_encode }
    
    var $api_url {
      value = "https://api.mapbox.com/geocoding/v5/mapbox.places/" ~ $encoded_address ~ ".json?access_token=" ~ $env.mapbox_access_token
    }
    
    // Add country filter if provided
    conditional {
      if ($input.country != "") {
        var.update $api_url {
          value = $api_url ~ "&country=" ~ $input.country
        }
      }
    }
    
    // Add limit parameter for best match
    var.update $api_url {
      value = $api_url ~ "&limit=1"
    }
    
    // Make the API request to Mapbox
    api.request {
      url = $api_url
      method = "GET"
      headers = ["Content-Type: application/json"]
      timeout = 30
    } as $api_result
    
    // Check for successful response
    precondition ($api_result.response.status == 200) {
      error_type = "standard"
      error = "Mapbox API error: " ~ ($api_result.response.status|to_text)
    }
    
    // Extract the geocoding results
    var $features { value = $api_result.response.result.features }
    
    // Check if any results were found
    precondition (($features|count) > 0) {
      error_type = "notfound"
      error = "No geocoding results found for address: " ~ $input.address
    }
    
    // Get the first (best) result
    var $first_result { value = $features|first }
    
    // Extract coordinates and place information
    var $coordinates { value = $first_result.geometry.coordinates }
    var $longitude { value = $coordinates|first }
    var $latitude { value = $coordinates|last }
    
    // Build the response
    var $place_type_first { value = ($first_result.place_type|first) ?? "" }
    var $geocoded_result {
      value = {
        place_name: $first_result.place_name
        longitude: $longitude
        latitude: $latitude
        accuracy: $first_result.properties.accuracy ?? ""
        place_type: $place_type_first
        address: $first_result.address ?? ""
        text: $first_result.text ?? ""
        full_response: $first_result
      }
    }
    
    debug.log {
      value = "Geocoded '" ~ $input.address ~ "' to coordinates: " ~ ($longitude|to_text) ~ ", " ~ ($latitude|to_text)
    }
  }
  response = $geocoded_result
}
