function "process_image" {
  description = "Process and optimize images using Imgix API"
  input {
    text image_url filters=trim { description = "Source image URL to process" }
    text width? filters=trim { description = "Target width in pixels (optional)" }
    text height? filters=trim { description = "Target height in pixels (optional)" }
    text format?="auto" filters=trim { description = "Output format: webp, jpg, png, auto (default: auto)" }
    text quality?="75" filters=trim { description = "Image quality 1-100 (default: 75)" }
    text fit?="crop" filters=trim { description = "Resize fit mode: crop, clip, max, scale (default: crop)" }
    text params? filters=trim { description = "Additional Imgix params as query string (optional, e.g., 'blur=50&sat=-100')" }
  }

  stack {
    // Get API key and domain from environment
    var $api_key { value = $env.IMGIX_API_KEY }
    var $imgix_domain { value = $env.IMGIX_DOMAIN }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "IMGIX_API_KEY environment variable not configured"
    }

    // Validate domain is configured
    precondition ($imgix_domain != null && $imgix_domain != "") {
      error_type = "standard"
      error = "IMGIX_DOMAIN environment variable not configured"
    }

    // Validate image URL is provided
    precondition ($input.image_url != null && $input.image_url != "") {
      error_type = "inputerror"
      error = "Image URL is required"
    }

    // Build the Imgix URL with parameters
    var $base_url {
      value = "https://" ~ $imgix_domain ~ "/" ~ ($input.image_url|url_encode)
    }

    // Start building query parameters
    var $query_params {
      value = "auto=compress,format"
    }

    // Add width if provided
    conditional {
      if ($input.width != null && $input.width != "") {
        var $query_params {
          value = $query_params ~ "&w=" ~ $input.width
        }
      }
    }

    // Add height if provided
    conditional {
      if ($input.height != null && $input.height != "") {
        var $query_params {
          value = $query_params ~ "&h=" ~ $input.height
        }
      }
    }

    // Add format if provided (and not auto)
    conditional {
      if ($input.format != null && $input.format != "" && $input.format != "auto") {
        var $query_params {
          value = $query_params ~ "&fm=" ~ $input.format
        }
      }
    }

    // Add quality
    conditional {
      if ($input.quality != null && $input.quality != "") {
        var $query_params {
          value = $query_params ~ "&q=" ~ $input.quality
        }
      }
    }

    // Add fit mode
    conditional {
      if ($input.fit != null && $input.fit != "") {
        var $query_params {
          value = $query_params ~ "&fit=" ~ $input.fit
        }
      }
    }

    // Add additional params if provided
    conditional {
      if ($input.params != null && $input.params != "") {
        var $query_params {
          value = $query_params ~ "&" ~ $input.params
        }
      }
    }

    // Build the final processed URL
    var $processed_url { value = $base_url ~ "?" ~ $query_params }

    // Get image metadata via HEAD request to verify URL is valid
    api.request {
      url = $processed_url
      method = "HEAD"
      timeout = 30
    } as $head_result

    // Initialize response variables
    var $success { value = false }
    var $final_url { value = null }
    var $content_type { value = null }
    var $content_length { value = null }
    var $error_message { value = null }
    var $width_used { value = $input.width }
    var $height_used { value = $input.height }

    // Parse response based on status
    conditional {
      if ($head_result.response.status == 200) {
        var $success { value = true }
        var $final_url { value = $processed_url }
        var $content_type {
          value = $head_result.response.headers|get:"content-type"
        }
        var $content_length {
          value = $head_result.response.headers|get:"content-length"
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Imgix error: HTTP " ~ ($head_result.response.status|to_text)
        }
      }
    }
  }

  response = {
    success: $success,
    processed_url: $final_url,
    original_url: $input.image_url,
    width: $width_used,
    height: $height_used,
    format: $input.format,
    content_type: $content_type,
    content_length_bytes: $content_length,
    error: $error_message
  }
}
