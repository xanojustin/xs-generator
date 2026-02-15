function "search_gifs" {
  description = "Search for GIFs using the Giphy API"
  input {
    text query { description = "Search query for GIFs" }
    int limit?=10 { description = "Maximum number of results (default: 10, max: 50)" }
    text rating?="g" { description = "Content rating: g, pg, pg-13, r (default: g)" }
    text lang?="en" { description = "Language code (default: en)" }
  }
  stack {
    // Validate limit
    var $limit {
      value = ($input.limit > 50) ? 50 : (($input.limit < 1) ? 10 : $input.limit)
    }
    
    // Validate rating - use simple conditional
    conditional {
      if ($input.rating == "g") {
        var $rating { value = "g" }
      }
      elseif ($input.rating == "pg") {
        var $rating { value = "pg" }
      }
      elseif ($input.rating == "pg-13") {
        var $rating { value = "pg-13" }
      }
      elseif ($input.rating == "r") {
        var $rating { value = "r" }
      }
      else {
        var $rating { value = "g" }
      }
    }
    
    // Build API request
    api.request {
      url = "https://api.giphy.com/v1/gifs/search"
      method = "GET"
      params = {
        api_key: $env.giphy_api_key,
        q: $input.query,
        limit: $limit,
        offset: 0,
        rating: $rating,
        lang: $input.lang,
        bundle: "messaging_non_clips"
      }
    } as $giphy_response
    
    // Check response status
    precondition ($giphy_response.response.status == 200) {
      error_type = "standard"
      error = "Giphy API request failed with status: " ~ ($giphy_response.response.status|to_text)
    }
    
    // Parse response data
    var $gifs_data { value = $giphy_response.response.result.data }
    
    // Format results
    var $formatted_gifs { value = [] }
    
    foreach ($gifs_data) {
      each as $gif {
        var $gif_info {
          value = {
            id: $gif.id,
            title: $gif.title,
            url: $gif.url,
            embed_url: $gif.embed_url,
            images: {
              original: $gif.images.original.url,
              fixed_height: $gif.images.fixed_height.url,
              fixed_width: $gif.images.fixed_width.url,
              preview: $gif.images.preview_gif.url
            },
            user: ($gif.user != null) ? {
              username: $gif.user.username,
              display_name: $gif.user.display_name,
              avatar_url: $gif.user.avatar_url
            } : null
          }
        }
        var $formatted_gifs {
          value = $formatted_gifs|push:$gif_info
        }
      }
    }
    
    var $result {
      value = {
        query: $input.query,
        total_count: $giphy_response.response.result.pagination.total_count,
        count: $formatted_gifs|count,
        gifs: $formatted_gifs
      }
    }
  }
  response = $result
}
