run.job "Create Mux Video Asset" {
  main = {
    name: "create_video_asset"
    input: {
      video_url: "https://example.com/video.mp4"
      playback_policy: "public"
      test_mode: false
    }
  }
  env = ["MUX_TOKEN_ID", "MUX_TOKEN_SECRET"]
}
