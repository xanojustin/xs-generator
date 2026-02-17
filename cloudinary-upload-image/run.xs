run.job "Cloudinary Image Upload" {
  main = {
    name: "upload_image"
    input: {
      image_url: "https://res.cloudinary.com/demo/image/upload/sample.jpg"
      folder: "uploads/2024"
      tags: "sample,upload,test"
    }
  }
  env = ["CLOUDINARY_CLOUD_NAME", "CLOUDINARY_UPLOAD_PRESET"]
}
