function "search_tracks" {
  description = "Search for tracks on Spotify using the Web API"
  input {
    text query filters=trim
    int limit?=20
    text access_token
  }
  stack {
    // Build the request URL with query parameters
    var $search_url {
      value = "https://api.spotify.com/v1/search?q=" ~ ($input.query|url_encode) ~ "&type=track&limit=" ~ ($input.limit|to_text)
    }

    // Make the API request to Spotify
    api.request {
      url = $search_url
      method = "GET"
      headers = [
        "Authorization: Bearer " ~ $input.access_token,
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $spotify_response

    // Check if the request was successful
    precondition ($spotify_response.response.status == 200) {
      error_type = "standard"
      error = "Spotify API request failed with status: " ~ ($spotify_response.response.status|to_text)
    }

    // Extract the tracks from the response
    var $tracks {
      value = $spotify_response.response.result.tracks.items
    }

    // Format the results for easier consumption
    var $formatted_tracks {
      value = []
    }

    foreach ($tracks) {
      each as $track {
        var $track_info {
          value = {
            name: $track.name,
            artist: $track.artists[0].name,
            album: $track.album.name,
            spotify_url: $track.external_urls.spotify,
            preview_url: $track.preview_url ?? null,
            duration_ms: $track.duration_ms,
            popularity: $track.popularity
          }
        }
        var.update $formatted_tracks {
          value = $formatted_tracks ~ [$track_info]
        }
      }
    }

    // Get total results count
    var $total_results {
      value = $spotify_response.response.result.tracks.total
    }
  }
  response = {
    query: $input.query,
    total_results: $total_results,
    returned_count: $formatted_tracks|count,
    tracks: $formatted_tracks
  }
}
