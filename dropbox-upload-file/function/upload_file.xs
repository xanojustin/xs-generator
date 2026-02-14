function "upload_to_dropbox" {
  input {
    text file_content
    text dropbox_path
    text file_name
    text mode?="add"
  }
  stack {
    // Validate required inputs
    precondition ($input.file_content != "") {
      error_type = "inputerror"
      error = "file_content is required"
    }
    
    precondition ($input.dropbox_path != "") {
      error_type = "inputerror"
      error = "dropbox_path is required"
    }
    
    precondition ($input.file_name != "") {
      error_type = "inputerror"
      error = "file_name is required"
    }
    
    // Validate mode parameter
    var $valid_modes { value = ["add", "overwrite", "update"] }
    var $is_valid_mode { 
      value = $valid_modes|some:($$ == $input.mode) 
    }
    
    conditional {
      if (!$is_valid_mode) {
        throw {
          name = "ValidationError"
          value = "Invalid mode. Must be one of: add, overwrite, update"
        }
      }
    }
    
    // Decode base64 file content to binary
    var $file_data { 
      value = $input.file_content|base64_decode 
    }
    
    // Prepare Dropbox API headers
    // The dropbox-api-arg header contains metadata as JSON
    var $dropbox_api_arg { 
      value = {
        path: $input.dropbox_path,
        mode: $input.mode,
        autorename: true,
        mute: false
      }|json_encode 
    }
    
    // Make request to Dropbox API
    api.request {
      url = "https://content.dropboxapi.com/2/files/upload"
      method = "POST"
      params = $file_data
      headers = [
        "Authorization: Bearer " ~ $env.DROPBOX_ACCESS_TOKEN,
        "Content-Type: application/octet-stream",
        "Dropbox-API-Arg: " ~ $dropbox_api_arg
      ]
      timeout = 60
    } as $api_result
    
    // Handle API response
    conditional {
      if ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid or expired Dropbox access token"
        }
      }
      elseif ($api_result.response.status == 409) {
        throw {
          name = "ConflictError"
          value = "File already exists at path: " ~ $input.dropbox_path
        }
      }
      elseif ($api_result.response.status < 200 || $api_result.response.status >= 300) {
        var $error_body { value = $api_result.response.result|json_encode }
        throw {
          name = "DropboxAPIError"
          value = "Dropbox API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ $error_body
        }
      }
    }
    
    // Extract file metadata from successful response
    var $file_data_response { value = $api_result.response.result }
  }
  response = {
    success: true,
    file: {
      name: $file_data_response.name,
      path_lower: $file_data_response.path_lower,
      id: $file_data_response.id,
      size: $file_data_response.size,
      server_modified: $file_data_response.server_modified
    }
  }
}
