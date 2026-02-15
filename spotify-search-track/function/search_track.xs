function "search_track" {
  description = "Search for tracks on Spotify using the Spotify Web API"
  input {
    text query filters=trim { description = "Search query (song name, artist, etc.)" }
    int limit?=10 { description = "Maximum number of results (1-50, default: 10)" }
    text market?="US" filters=trim { description = "Market code for content restriction (default: US)" }
  }

  stack {
    // Get credentials from environment
    var $client_id { value = $env.SPOTIFY_CLIENT_ID }
    var $client_secret { value = $env.SPOTIFY_CLIENT_SECRET }

    // Validate credentials are configured
    precondition ($client_id != null && $client_id != "") {
      error_type = "standard"
      error = "SPOTIFY_CLIENT_ID environment variable not configured"
    }

    precondition ($client_secret != null && $client_secret != "") {
      error_type = "standard"
      error = "SPOTIFY_CLIENT_SECRET environment variable not configured"
    }

    // Validate query is provided
    precondition ($input.query != null && $input.query != "") {
      error_type = "inputerror"
      error = "Search query is required"
    }

    // Create base64 encoded credentials for token request
    var $credentials { value = $client_id ~ ":" ~ $client_secret }
    var $encoded_credentials { value = $credentials|base64_encode }

    // Get access token from Spotify
    api.request {
      url = "https://accounts.spotify.com/api/token"
      method = "POST"
      params = {
        grant_type: "client_credentials"
      }
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: Basic " ~ $encoded_credentials
      ]
    } as $token_response

    // Check if token request succeeded
    precondition ($token_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to authenticate with Spotify"
    }

    // Extract access token
    var $token_data { value = $token_response.response.result }
    var $access_token { value = $token_data|get:"access_token" }

    // Validate access token
    precondition ($access_token != null && $access_token != "") {
      error_type = "standard"
      error = "Failed to retrieve access token from Spotify"
    }

    // Build search URL with query parameters
    var $search_url { 
      value = "https://api.spotify.com/v1/search?q=" ~ ($input.query|url_encode) ~ "&type=track&limit=" ~ ($input.limit|to_text) ~ "&market=" ~ $input.market
    }

    // Search for tracks
    api.request {
      url = $search_url
      method = "GET"
      headers = [
        "Authorization: Bearer " ~ $access_token
      ]
    } as $search_response

    // Initialize response variables
    var $tracks { value = [] }
    var $total_results { value = 0 }

    // Parse search results
    conditional {
      if ($search_response.response.status == 200) {
        var $search_data { value = $search_response.response.result }
        var $tracks_data { value = $search_data|get:"tracks" }
        
        conditional {
          if ($tracks_data != null) {
            var $tracks { value = $tracks_data|get:"items" }
            var $total_results { value = $tracks_data|get:"total" }

            // Ensure tracks is an array
            conditional {
              if ($tracks == null) {
                var $tracks { value = [] }
              }
            }
          }
        }
      }
    }

    // Format tracks for response
    var $formatted_tracks { value = [] }

    foreach ($tracks) {
      each as $track {
        // Extract artist names
        var $artists { value = $track|get:"artists" }
        var $artist_names { value = [] }
        
        foreach ($artists) {
          each as $artist {
            var $artist_name { value = $artist|get:"name" }
            var $artist_names {
              value = $artist_names|push:$artist_name
            }
          }
        }

        // Get album info
        var $album { value = $track|get:"album" }
        var $album_name { value = "" }
        var $album_image { value = "" }
        
        conditional {
          if ($album != null) {
            var $album_name { value = $album|get:"name" }
            var $images { value = $album|get:"images" }
            
            conditional {
              if ($images != null && ($images|count) > 0) {
                var $first_image { value = $images|first }
                var $album_image { value = $first_image|get:"url" }
              }
            }
          }
        }

        // Build formatted track object
        var $formatted_track {
          value = {
            id: $track|get:"id",
            name: $track|get:"name",
            artists: $artist_names,
            album: $album_name,
            album_image: $album_image,
            duration_ms: $track|get:"duration_ms",
            preview_url: $track|get:"preview_url",
            spotify_url: $track|get:"external_urls"|get:"spotify",
            popularity: $track|get:"popularity"
          }
        }

        var $formatted_tracks {
          value = $formatted_tracks|push:$formatted_track
        }
      }
    }
  }

  response = {
    query: $input.query,
    total_results: $total_results,
    tracks_returned: $formatted_tracks|count,
    tracks: $formatted_tracks
  }
}
