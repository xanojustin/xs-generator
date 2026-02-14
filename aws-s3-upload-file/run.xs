run.job "AWS S3 File Upload" {
  main = {
    name: "s3_upload_file"
    input: {
      file_path: "example.txt"
      file_content: "Hello from XanoScript!"
      content_type: "text/plain"
    }
  }
  env = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "AWS_REGION", "AWS_S3_BUCKET"]
}
