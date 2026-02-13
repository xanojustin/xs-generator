function "upload_file_to_dropbox" {
  description = "Create a folder in Dropbox using the Dropbox API"
  input {
    text folder_path filters=trim
  }
  stack {
    // Validate input
    precondition (($input.folder_path|strlen) > 0) {
      error_type = "inputerror"
      error = "folder_path is required"
    }

    // Make the API request to Dropbox to create a folder
    api.request {
      url = "https://api.dropboxapi.com/2/files/create_folder_v2"
      method = "POST"
      headers = [
        "Authorization: Bearer " ~ $env.dropbox_access_token,
        "Content-Type: application/json"
      ]
      params = {
        path: $input.folder_path,
        autorename: false
      }
      timeout = 30
    } as $api_response

    // Check if the request was successful (200 or 409 for already exists)
    var $is_success {
      value = ($api_response.response.status == 200) || ($api_response.response.status == 409)
    }

    conditional {
      if (!$is_success) {
        throw {
          name = "DropboxAPIError"
          value = "Dropbox API request failed with status: " ~ ($api_response.response.status|to_text)
        }
      }
    }

    // Parse the response
    var $dropbox_result {
      value = $api_response.response.result
    }

    // Check if folder already existed
    var $already_existed {
      value = $api_response.response.status == 409
    }

    // Log success
    debug.log {
      value = "Dropbox folder operation completed: " ~ $input.folder_path
    }
  }
  response = {
    success: true,
    message: $already_existed ? "Folder already exists" : "Folder created successfully",
    folder_path: $input.folder_path,
    already_existed: $already_existed,
    dropbox_response: $dropbox_result
  }
}
