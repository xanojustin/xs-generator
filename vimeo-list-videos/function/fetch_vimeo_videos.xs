function "fetch_vimeo_videos" {
  input {
    int page?=1
    int per_page?=10
    text filter?=""
    text sort?="date"
    text direction?="desc"
  }

  stack {
    // Build query parameters
    var $query_params {
      value = {
        page: $input.page
        per_page: $input.per_page
        sort: $input.sort
        direction: $input.direction
      }
    }

    // Add filter if provided
    conditional {
      if ($input.filter != "") {
        var.update $query_params {
          value = $query_params|set:"query":$input.filter
        }
      }
    }

    // Build URL with query string
    var $base_url { value = "https://api.vimeo.com/me/videos" }
    var $url {
      value = $base_url ~ "?page=" ~ ($input.page|to_text) ~ "&per_page=" ~ ($input.per_page|to_text) ~ "&sort=" ~ $input.sort ~ "&direction=" ~ $input.direction
    }

    // Add filter to URL if present
    conditional {
      if ($input.filter != "") {
        var.update $url {
          value = $url ~ "&query=" ~ $input.filter
        }
      }
    }

    // Make API request to Vimeo
    api.request {
      url = $url
      method = "GET"
      headers = [
        "Accept: application/vnd.vimeo.*+json;version=3.4",
        "Authorization: Bearer " ~ $env.VIMEO_ACCESS_TOKEN
      ]
      timeout = 30
    } as $api_result

    // Check response status
    precondition ($api_result.response.status == 200) {
      error_type = "standard"
      error = "Vimeo API request failed with status " ~ ($api_result.response.status|to_text)
    }

    // Extract video data
    var $response_data { value = $api_result.response.result }
    var $videos { value = $response_data.data ?? [] }
    var $total { value = $response_data.total ?? 0 }
    var $page { value = $response_data.page ?? $input.page }
    var $per_page { value = $response_data.per_page ?? $input.per_page }

    // Calculate total pages
    var $total_pages {
      value = ($total / $per_page)|ceil
    }

    // Format video data for clean output
    var $formatted_videos { value = [] }
    foreach ($videos) {
      each as $video {
        // Safely extract nested properties
        var $privacy_view { value = ($video|get:"privacy":{})|get:"view":"unknown" }
        var $pictures_sizes { value = ($video|get:"pictures":{})|get:"sizes":[] }

        var $video_info {
          value = {
            uri: $video.uri
            name: $video.name ?? "Untitled"
            description: $video.description ?? ""
            link: $video.link
            duration: $video.duration ?? 0
            width: $video.width ?? 0
            height: $video.height ?? 0
            created_time: $video.created_time
            modified_time: $video.modified_time
            privacy: $privacy_view
            status: $video.status ?? "unknown"
            pictures: $pictures_sizes
          }
        }
        var.update $formatted_videos {
          value = $formatted_videos|push:$video_info
        }
      }
    }
  }

  response = {
    success: true
    pagination: {
      page: $page
      per_page: $per_page
      total: $total
      total_pages: $total_pages
      has_next: $page < $total_pages
      has_previous: $page > 1
    }
    videos: $formatted_videos
    count: $formatted_videos|count
  }
}
