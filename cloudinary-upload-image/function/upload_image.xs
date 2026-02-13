function "upload_image" {
  description = "Upload an image to Cloudinary using unsigned uploads"
  input {
    text image_url { description = "URL of the image to upload" }
    text public_id? { description = "Optional public ID for the uploaded image" }
  }
  stack {
    // Build the Cloudinary upload URL
    var $upload_url {
      value = "https://api.cloudinary.com/v1_1/" ~ $env.CLOUDINARY_CLOUD_NAME ~ "/image/upload"
    }

    // Prepare the request parameters
    var $params {
      value = {
        file: $input.image_url,
        upload_preset: $env.CLOUDINARY_UPLOAD_PRESET,
        api_key: $env.CLOUDINARY_API_KEY
      }
    }

    // Add public_id if provided
    conditional {
      if ($input.public_id != null && $input.public_id != "") {
        var $params {
          value = $params|merge:{ public_id: $input.public_id }
        }
      }
    }

    // Make the upload request to Cloudinary
    api.request {
      url = $upload_url
      method = "POST"
      params = $params
      timeout = 60
    } as $api_response

    // Check if the request was successful
    precondition ($api_response.response.status == 200) {
      error_type = "standard"
      error = "Cloudinary upload failed: " ~ $api_response.response.result|json_encode
    }

    // Extract the result
    var $result { value = $api_response.response.result }
  }
  response = {
    success: true,
    public_id: $result.public_id,
    url: $result.secure_url,
    format: $result.format,
    width: $result.width,
    height: $result.height,
    bytes: $result.bytes,
    created_at: $result.created_at
  }
}
