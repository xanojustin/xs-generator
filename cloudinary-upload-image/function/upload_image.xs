function "upload_image" {
  description = "Upload an image to Cloudinary using the Upload API"
  input {
    text image_url { description = "URL of the image to upload" }
    text public_id { description = "Public ID for the uploaded image (optional)" }
    text folder { description = "Folder path in Cloudinary (optional)" }
  }
  stack {
    // Build the upload URL
    var $upload_url {
      value = "https://api.cloudinary.com/v1_1/" ~ $env.cloudinary_cloud_name ~ "/image/upload"
    }

    // Generate timestamp for signature
    var $timestamp {
      value = now|to_seconds
    }

    // Prepare the payload
    var $payload {
      value = {
        file: $input.image_url,
        api_key: $env.cloudinary_api_key,
        timestamp: $timestamp
      }
    }

    // Add optional parameters if provided
    conditional {
      if (`$input.public_id != ""`) {
        var $payload {
          value = $payload|set:"public_id":$input.public_id
        }
      }
    }

    conditional {
      if (`$input.folder != ""`) {
        var $payload {
          value = $payload|set:"folder":$input.folder
        }
      }
    }

    // Generate signature (required for authenticated uploads)
    // Signature is: sha1(sorted_params + api_secret)
    var $signature_string {
      value = "file=" ~ $input.image_url ~ "&timestamp=" ~ ($timestamp|to_text) ~ $env.cloudinary_api_secret
    }

    conditional {
      if (`$input.public_id != ""`) {
        var $signature_string {
          value = "file=" ~ $input.image_url ~ "&public_id=" ~ $input.public_id ~ "&timestamp=" ~ ($timestamp|to_text) ~ $env.cloudinary_api_secret
        }
      }
    }

    var $signature {
      value = $signature_string|sha1
    }

    // Add signature to payload
    var $payload {
      value = $payload|set:"signature":$signature
    }

    // Make the API request to Cloudinary
    api.request {
      url = $upload_url
      method = "POST"
      params = $payload
      headers = ["Content-Type: application/x-www-form-urlencoded"]
      timeout = 60
    } as $upload_result

    // Validate the response
    precondition ($upload_result.response.status >= 200 && $upload_result.response.status < 300) {
      error_type = "standard"
      error = "Cloudinary upload failed: " ~ ($upload_result.response.status|to_text)
    }

    // Extract the upload result
    var $result {
      value = $upload_result.response.result
    }

    // Verify we got expected response fields
    precondition ($result|has:"secure_url") {
      error_type = "standard"
      error = "Invalid response from Cloudinary: missing secure_url"
    }
  }
  response = {
    success: true
    public_id: $result.public_id
    secure_url: $result.secure_url
    url: $result.url
    format: $result.format
    width: $result.width
    height: $result.height
    bytes: $result.bytes
    created_at: $result.created_at
    original_filename: $result.original_filename
  }
}
