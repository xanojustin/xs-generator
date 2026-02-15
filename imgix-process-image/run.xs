run.job "Imgix Process Image" {
  main = {
    name: "process_image"
    input: {
      image_url: "https://assets.imgix.net/examples/pione.jpg"
      width: "800"
      height: "600"
      format: "webp"
      quality: "85"
    }
  }
  env = ["IMGIX_API_KEY", "IMGIX_DOMAIN"]
}
