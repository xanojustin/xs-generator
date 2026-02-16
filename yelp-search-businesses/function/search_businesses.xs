function "search_businesses" {
  description = "Search for businesses using the Yelp Fusion API"
  input {
    text term { description = "Search term (e.g., 'coffee', 'restaurants', 'plumbers')" }
    text location { description = "Location to search (e.g., 'San Francisco, CA', 'NYC')" }
    int limit?=10 { description = "Number of results (max 50, default 10)" }
    text sort_by?="best_match" { description = "Sort by: best_match, rating, review_count, distance" }
    text price?="1,2,3,4" { description = "Price levels: 1=$, 2=$$, 3=$$$, 4=$$$$ (comma-separated)" }
    text open_now?="false" { description = "Filter by open now: true or false" }
  }
  stack {
    // Validate and clamp limit
    var $limit {
      value = ($input.limit > 50) ? 50 : (($input.limit < 1) ? 10 : $input.limit)
    }
    
    // Build query parameters
    var $params {
      value = {
        term: $input.term,
        location: $input.location,
        limit: $limit,
        sort_by: $input.sort_by
      }
    }
    
    // Add price filter if provided
    conditional {
      if ($input.price != null && $input.price != "") {
        var $params {
          value = $params|set:"price":$input.price
        }
      }
    }
    
    // Add open_now filter if true
    conditional {
      if ($input.open_now == "true") {
        var $params {
          value = $params|set:"open_now":"true"
        }
      }
    }
    
    // Make Yelp Fusion API request
    api.request {
      url = "https://api.yelp.com/v3/businesses/search"
      method = "GET"
      params = $params
      headers = [
        "Authorization: Bearer " ~ $env.yelp_api_key
      ]
    } as $yelp_response
    
    // Check response status
    precondition ($yelp_response.response.status == 200) {
      error_type = "standard"
      error = "Yelp API request failed with status: " ~ ($yelp_response.response.status|to_text)
    }
    
    // Parse response data
    var $businesses_data { value = $yelp_response.response.result.businesses }
    var $total { value = $yelp_response.response.result.total }
    var $region { value = $yelp_response.response.result.region }
    
    // Format businesses
    var $formatted_businesses { value = [] }
    
    foreach ($businesses_data) {
      each as $biz {
        var $biz_info {
          value = {
            id: $biz.id,
            name: $biz.name,
            image_url: $biz.image_url,
            url: $biz.url,
            review_count: $biz.review_count,
            rating: $biz.rating,
            price: ($biz.price != null) ? $biz.price : null,
            phone: $biz.phone,
            display_phone: $biz.display_phone,
            distance: ($biz.distance != null) ? ($biz.distance / 1609.34) : null,
            categories: $biz.categories|map:$$.title,
            location: {
              address1: $biz.location.address1,
              address2: $biz.location.address2,
              address3: $biz.location.address3,
              city: $biz.location.city,
              zip_code: $biz.location.zip_code,
              country: $biz.location.country,
              state: $biz.location.state,
              display_address: $biz.location.display_address
            },
            coordinates: {
              latitude: $biz.coordinates.latitude,
              longitude: $biz.coordinates.longitude
            },
            is_closed: $biz.is_closed
          }
        }
        var $formatted_businesses {
          value = $formatted_businesses|push:$biz_info
        }
      }
    }
    
    // Build final result
    var $result {
      value = {
        search_params: {
          term: $input.term,
          location: $input.location,
          limit: $limit,
          sort_by: $input.sort_by
        },
        total_results: $total,
        returned_count: $formatted_businesses|count,
        region_center: ($region != null && $region.center != null) ? {
          latitude: $region.center.latitude,
          longitude: $region.center.longitude
        } : null,
        businesses: $formatted_businesses
      }
    }
  }
  response = $result
}
