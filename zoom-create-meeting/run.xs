run.job "Zoom Create Meeting" {
  main = {
    name: "zoom_create_meeting"
    input: {
      topic: "Team Weekly Standup"
      duration: 60
      timezone: "America/Los_Angeles"
      agenda: "Weekly team sync meeting"
    }
  }
  env = ["ZOOM_ACCOUNT_ID", "ZOOM_CLIENT_ID", "ZOOM_CLIENT_SECRET"]
}
