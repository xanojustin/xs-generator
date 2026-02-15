function "geocode_address" {
  description = "Geocode an address using Google Maps Geocoding API"
  input {
    text address { description = "The address to geocode (street, city, state, etc.)" }
  }
  stack {
    var $encoded_address { value = ($input.address|url_encode) }
    
    var $api_url { 
      value = "https://maps.googleapis.com/maps/api/geocode/json?address=" ~ $encoded_address ~ "&key=" ~ $env.google_maps_api_key
    }
    
    api.request {
      url = $api_url
      method = "GET"
    } as $geocode_response
    
    precondition ($geocode_response.response.status == "OK") {
      error_type = "standard"
      error = "Geocoding API request failed: " ~ ($geocode_response.response.status|to_text)
    }
    
    var $results { value = $geocode_response.response.results }
    
    precondition (($results|count) > 0) {
      error_type = "standard"
      error = "No geocoding results found for the provided address"
    }
    
    var $first_result { value = ($results|first) }
    var $geometry { value = $first_result.geometry }
    var $location { value = $geometry.location }
    var $formatted_address { value = $first_result.formatted_address }
    var $place_id { value = $first_result.place_id }
    var $location_type { value = $geometry.location_type }
    
    var $result {
      value = {
        formatted_address: $formatted_address,
        place_id: $place_id,
        latitude: $location.lat,
        longitude: $location.lng,
        location_type: $location_type,
        partial_match: $first_result.partial_match
      }
    }
  }
  response = $result
}
