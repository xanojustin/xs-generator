function "upload_file" {
  description = "Upload a file to Dropbox using the Dropbox API"
  input {
    text file_path
    text file_content
  }
  stack {
    // Build the Dropbox API URL for file upload
    api.request {
      url = "https://content.dropboxapi.com/2/files/upload"
      method = "POST"
      params = $input.file_content
      headers = [
        "Authorization: Bearer " ~ $env.DROPBOX_ACCESS_TOKEN,
        "Content-Type: application/octet-stream",
        "Dropbox-API-Arg: {" ~ "\"path\": \"" ~ $input.file_path ~ "\", \"mode\": \"add\", \"autorename\": true, \"mute\": false}" ~ ""
      ]
      timeout = 60
    } as $upload_result

    // Check if upload was successful
    precondition ($upload_result.response.status == 200) {
      error_type = "standard"
      error = "Dropbox upload failed: " ~ ($upload_result.response.result|json_encode)
    }

    // Parse the response
    var $upload_response { value = $upload_result.response.result }
  }
  response = $upload_response
}
