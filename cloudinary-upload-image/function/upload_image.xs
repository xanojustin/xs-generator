// Upload an image to Cloudinary
// Cloudinary is a cloud-based media management platform

function "upload_image" {
  input {
    text image_url
    text public_id?=""
    text folder?=""
    bool overwrite?=false
    text tags?=""
  }

  stack {
    precondition ($input.image_url != "") {
      error_type = "inputerror"
      error = "image_url is required"
    }

    var $payload {
      value = {
        file: $input.image_url
        upload_preset: $env.CLOUDINARY_UPLOAD_PRESET
      }
    }

    conditional {
      if ($input.folder != "") {
        var.update $payload {
          value = $payload|set:"folder":$input.folder
        }
      }
    }

    conditional {
      if ($input.public_id != "") {
        var.update $payload {
          value = $payload|set:"public_id":$input.public_id
        }
      }
    }

    conditional {
      if ($input.tags != "") {
        var.update $payload {
          value = $payload|set:"tags":$input.tags
        }
      }
    }

    conditional {
      if ($input.overwrite == true) {
        var.update $payload {
          value = $payload|set:"overwrite":true
        }
      }
    }

    var $upload_url {
      value = "https://api.cloudinary.com/v1_1/" ~ $env.CLOUDINARY_CLOUD_NAME ~ "/image/upload"
    }

    api.request {
      url = $upload_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 60
    } as $api_result

    conditional {
      if ($api_result.response.status == 200) {
        var $uploaded_image {
          value = $api_result.response.result
        }

        var $result {
          value = {
            success: true
            message: "Image uploaded successfully"
            image: {
              public_id: $uploaded_image|get:"public_id":""
              version: $uploaded_image|get:"version":""
              signature: $uploaded_image|get:"signature":""
              width: $uploaded_image|get:"width":0
              height: $uploaded_image|get:"height":0
              format: $uploaded_image|get:"format":""
              resource_type: $uploaded_image|get:"resource_type":""
              created_at: $uploaded_image|get:"created_at":""
              bytes: $uploaded_image|get:"bytes":0
              url: $uploaded_image|get:"url":""
              secure_url: $uploaded_image|get:"secure_url":""
            }
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        throw {
          name = "UploadError"
          value = "Invalid request: " ~ ($api_result.response.result|get:"error"|get:"message":"Unknown error")
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthError"
          value = "Invalid Cloudinary credentials"
        }
      }
      else {
        throw {
          name = "APIError"
          value = "Cloudinary API error (status " ~ ($api_result.response.status|to_text) ~ ")"
        }
      }
    }
  }

  response = $result
}
