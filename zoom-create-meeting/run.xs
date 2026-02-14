run.job "Create Zoom Meeting" {
  main = {
    name: "create_zoom_meeting"
    input: {
      topic: "Meeting created via Xano"
      duration: 30
      start_time: null
    }
  }
  env = ["zoom_account_id", "zoom_client_id", "zoom_client_secret"]
}
