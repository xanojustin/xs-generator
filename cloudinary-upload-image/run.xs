run.job "Cloudinary Upload Image" {
  main = {
    name: "upload_image"
    input: {
      image_url: "https://example.com/sample-image.jpg"
      public_id: "sample_upload"
      folder: "uploads"
    }
  }
  env = ["cloudinary_cloud_name", "cloudinary_api_key", "cloudinary_api_secret"]
}
