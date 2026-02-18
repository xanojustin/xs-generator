run.job "AWS S3 File Operations" {
  main = {
    name: "s3_file_manager"
    input: {
      operation: "list_and_upload"
      bucket: "my-example-bucket"
      prefix: "uploads/"
    }
  }
  env = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "AWS_REGION", "AWS_S3_BUCKET"]
}
