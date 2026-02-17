// Run Job Configuration for Zoom Meeting Creation
// Executes the create_zoom_meeting function
run.job "Create Zoom Meeting" {
  main = {
    name: "create_zoom_meeting"
    input: {
      topic: "Team Standup Meeting"
      agenda: "Daily team sync - project updates and blockers"
      start_time: "2025-02-17T10:00:00"
      duration: 30
      timezone: "America/Los_Angeles"
      waiting_room: true
      join_before_host: false
    }
  }
  env = ["ZOOM_ACCOUNT_ID", "ZOOM_CLIENT_ID", "ZOOM_CLIENT_SECRET"]
}
