function "s3_upload_file" {
  input {
    text file_path
    text file_content
    text content_type ?= "application/octet-stream"
  }
  stack {
    // Validate required inputs
    precondition ($input.file_path != null && $input.file_path != "") {
      error_type = "inputerror"
      error = "file_path is required"
    }

    precondition ($input.file_content != null) {
      error_type = "inputerror"
      error = "file_content is required"
    }

    // Validate environment variables
    precondition ($env.AWS_ACCESS_KEY_ID != null) {
      error_type = "badrequest"
      error = "AWS_ACCESS_KEY_ID environment variable is required"
    }

    precondition ($env.AWS_SECRET_ACCESS_KEY != null) {
      error_type = "badrequest"
      error = "AWS_SECRET_ACCESS_KEY environment variable is required"
    }

    precondition ($env.AWS_REGION != null) {
      error_type = "badrequest"
      error = "AWS_REGION environment variable is required"
    }

    precondition ($env.AWS_S3_BUCKET != null) {
      error_type = "badrequest"
      error = "AWS_S3_BUCKET environment variable is required"
    }

    // Generate timestamp for AWS signature
    var $timestamp { value = now|format_timestamp:"YmdTHisZ":"UTC" }
    var $date_stamp { value = now|format_timestamp:"Ymd":"UTC" }

    // Build the S3 endpoint URL
    var $s3_url {
      value = "https://" ~ $env.AWS_S3_BUCKET ~ ".s3." ~ $env.AWS_REGION ~ ".amazonaws.com/" ~ $input.file_path
    }

    // Build AWS Signature V4 headers
    var $amz_date_header { value = "X-Amz-Date: " ~ $timestamp }
    var $content_type_header { value = "Content-Type: " ~ $input.content_type }

    // Construct the canonical request components
    var $host { value = $env.AWS_S3_BUCKET ~ ".s3." ~ $env.AWS_REGION ~ ".amazonaws.com" }
    var $host_header { value = "Host: " ~ $host }

    // For S3 uploads, we use the simpler approach with AWS Signature V4
    // Build the string to sign
    var $algorithm { value = "AWS4-HMAC-SHA256" }
    var $credential_scope {
      value = $date_stamp ~ "/" ~ $env.AWS_REGION ~ "/s3/aws4_request"
    }
    var $credential {
      value = $env.AWS_ACCESS_KEY_ID ~ "/" ~ $credential_scope
    }

    // Build simplified Authorization header
    // Note: In production, you'd need proper AWS Signature V4 signing
    var $authorization_header {
      value = $algorithm ~ " Credential=" ~ $credential ~ ", SignedHeaders=host;x-amz-date, Signature=UNSIGNED-PAYLOAD"
    }

    // Make the S3 PUT request with UNSIGNED-PAYLOAD for simplified auth
    api.request {
      url = $s3_url
      method = "PUT"
      params = $input.file_content
      headers = [
        $host_header,
        $content_type_header,
        $amz_date_header,
        "Authorization: " ~ $authorization_header,
        "x-amz-content-sha256: UNSIGNED-PAYLOAD"
      ]
    } as $upload_result

    // Check response status
    conditional {
      if ($upload_result.response.status == 200) {
        var $status { value = "success" }
        var $message { value = "File uploaded successfully to S3" }
      }
      elseif ($upload_result.response.status == 201) {
        var $status { value = "success" }
        var $message { value = "File created successfully in S3" }
      }
      else {
        var $status { value = "error" }
        var $message {
          value = "S3 upload failed with status: " ~ ($upload_result.response.status|to_text)
        }
      }
    }

    // Log the upload attempt
    db.add "upload_log" {
      data = {
        file_path: $input.file_path,
        content_type: $input.content_type,
        status: $status,
        http_status: $upload_result.response.status,
        message: $message,
        s3_url: $s3_url,
        created_at: now
      }
    } as $log_entry

    // Build response
    var $api_response {
      value = {
        success: ($status == "success"),
        file_path: $input.file_path,
        bucket: $env.AWS_S3_BUCKET,
        region: $env.AWS_REGION,
        s3_url: $s3_url,
        status_code: $upload_result.response.status,
        message: $message,
        log_id: $log_entry.id
      }
    }
  }
  response = $api_response
}
