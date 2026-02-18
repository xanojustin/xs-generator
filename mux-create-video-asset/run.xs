run.job "Mux Create Video Asset" {
  main = {
    name: "create_mux_asset"
    input: {
      video_url: "https://example.com/video.mp4"
      title: "My Video"
    }
  }
  env = ["MUX_TOKEN_ID", "MUX_TOKEN_SECRET"]
}