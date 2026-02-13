run.job "Cloudinary Image Upload" {
  main = {
    name: "upload_image"
    input: {
      image_url: "https://picsum.photos/400/300"
      public_id: "sample_upload"
    }
  }
  env = ["CLOUDINARY_CLOUD_NAME", "CLOUDINARY_API_KEY", "CLOUDINARY_UPLOAD_PRESET"]
}
