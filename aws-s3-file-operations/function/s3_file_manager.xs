function "s3_file_manager" {
  description = "Manages AWS S3 file operations including listing, uploading, reading, and generating signed URLs"
  input {
    text operation
    text bucket?
    text prefix?=""
    text file_key?
    json file_data?
  }
  stack {
    var $bucket_name {
      value = $input.bucket ?? $env.AWS_S3_BUCKET
    }

    precondition ($bucket_name != null && $bucket_name != "") {
      error_type = "inputerror"
      error = "Bucket name is required. Provide via input.bucket or AWS_S3_BUCKET environment variable."
    }

    var $region {
      value = $env.AWS_REGION ?? "us-east-1"
    }

    var $result {
      value = {}
    }

    switch ($input.operation) {
      case ("list") {
        cloud.aws.s3.list_directory {
          bucket = $bucket_name
          region = $region
          key = $env.AWS_ACCESS_KEY_ID
          secret = $env.AWS_SECRET_ACCESS_KEY
          prefix = $input.prefix
        } as $list_result

        var.update $result {
          value = {
            operation: "list"
            bucket: $bucket_name
            prefix: $input.prefix
            files: $list_result.files ?? []
            count: ($list_result.files ?? [])|count
          }
        }

        db.add "file_log" {
          data = {
            operation: "list"
            bucket: $bucket_name
            prefix: $input.prefix
            file_count: ($list_result.files ?? [])|count
            created_at: now
          }
        }
      } break

      case ("upload") {
        precondition ($input.file_key != null && $input.file_key != "") {
          error_type = "inputerror"
          error = "file_key is required for upload operation"
        }

        precondition ($input.file_data != null) {
          error_type = "inputerror"
          error = "file_data is required for upload operation"
        }

        cloud.aws.s3.upload_file {
          bucket = $bucket_name
          region = $region
          key = $env.AWS_ACCESS_KEY_ID
          secret = $env.AWS_SECRET_ACCESS_KEY
          file_key = $input.file_key
          file = $input.file_data
        } as $upload_result

        var.update $result {
          value = {
            operation: "upload"
            bucket: $bucket_name
            file_key: $input.file_key
            success: true
            etag: $upload_result.etag
            location: $upload_result.location
          }
        }

        db.add "file_log" {
          data = {
            operation: "upload"
            bucket: $bucket_name
            file_key: $input.file_key
            success: true
            created_at: now
          }
        }
      } break

      case ("read") {
        precondition ($input.file_key != null && $input.file_key != "") {
          error_type = "inputerror"
          error = "file_key is required for read operation"
        }

        cloud.aws.s3.read_file {
          bucket = $bucket_name
          region = $region
          key = $env.AWS_ACCESS_KEY_ID
          secret = $env.AWS_SECRET_ACCESS_KEY
          file_key = $input.file_key
        } as $file_content

        var.update $result {
          value = {
            operation: "read"
            bucket: $bucket_name
            file_key: $input.file_key
            content: $file_content
            size: ($file_content|strlen)
          }
        }

        db.add "file_log" {
          data = {
            operation: "read"
            bucket: $bucket_name
            file_key: $input.file_key
            created_at: now
          }
        }
      } break

      case ("sign_url") {
        precondition ($input.file_key != null && $input.file_key != "") {
          error_type = "inputerror"
          error = "file_key is required for sign_url operation"
        }

        cloud.aws.s3.sign_url {
          bucket = $bucket_name
          region = $region
          key = $env.AWS_ACCESS_KEY_ID
          secret = $env.AWS_SECRET_ACCESS_KEY
          file_key = $input.file_key
          ttl = 3600
        } as $signed_url

        var.update $result {
          value = {
            operation: "sign_url"
            bucket: $bucket_name
            file_key: $input.file_key
            signed_url: $signed_url.url
            expires_in: 3600
            expires_at: now|transform_timestamp:"+1 hour"
          }
        }

        db.add "file_log" {
          data = {
            operation: "sign_url"
            bucket: $bucket_name
            file_key: $input.file_key
            created_at: now
          }
        }
      } break

      case ("delete") {
        precondition ($input.file_key != null && $input.file_key != "") {
          error_type = "inputerror"
          error = "file_key is required for delete operation"
        }

        cloud.aws.s3.delete_file {
          bucket = $bucket_name
          region = $region
          key = $env.AWS_ACCESS_KEY_ID
          secret = $env.AWS_SECRET_ACCESS_KEY
          file_key = $input.file_key
        }

        var.update $result {
          value = {
            operation: "delete"
            bucket: $bucket_name
            file_key: $input.file_key
            success: true
            deleted_at: now
          }
        }

        db.add "file_log" {
          data = {
            operation: "delete"
            bucket: $bucket_name
            file_key: $input.file_key
            success: true
            created_at: now
          }
        }
      } break

      case ("list_and_upload") {
        cloud.aws.s3.list_directory {
          bucket = $bucket_name
          region = $region
          key = $env.AWS_ACCESS_KEY_ID
          secret = $env.AWS_SECRET_ACCESS_KEY
          prefix = $input.prefix
        } as $list_result

        var $test_content {
          value = "This is a test file uploaded by Xano Run Job at " ~ (now|format_timestamp:"Y-m-d H:i:s":"UTC")
        }

        var $timestamp {
          value = now|format_timestamp:"YmdHis":"UTC"
        }

        var $test_file_key {
          value = $input.prefix ~ "test-upload-" ~ $timestamp ~ ".txt"
        }

        cloud.aws.s3.upload_file {
          bucket = $bucket_name
          region = $region
          key = $env.AWS_ACCESS_KEY_ID
          secret = $env.AWS_SECRET_ACCESS_KEY
          file_key = $test_file_key
          file = $test_content
        } as $upload_result

        cloud.aws.s3.sign_url {
          bucket = $bucket_name
          region = $region
          key = $env.AWS_ACCESS_KEY_ID
          secret = $env.AWS_SECRET_ACCESS_KEY
          file_key = $test_file_key
          ttl = 3600
        } as $signed_url

        var.update $result {
          value = {
            operation: "list_and_upload"
            bucket: $bucket_name
            prefix: $input.prefix
            existing_files: ($list_result.files ?? [])|count
            uploaded_file: {
              key: $test_file_key
              etag: $upload_result.etag
              signed_url: $signed_url.url
              expires_in: 3600
            }
            message: "Listed existing files and uploaded test file successfully"
          }
        }

        db.add "file_log" {
          data = {
            operation: "list_and_upload"
            bucket: $bucket_name
            prefix: $input.prefix
            existing_count: ($list_result.files ?? [])|count
            uploaded_file: $test_file_key
            created_at: now
          }
        }
      } break

      default {
        throw {
          name = "InvalidOperation"
          value = "Unknown operation: " ~ $input.operation ~ ". Valid operations: list, upload, read, sign_url, delete, list_and_upload"
        }
      }
    }
  }
  response = $result
}
