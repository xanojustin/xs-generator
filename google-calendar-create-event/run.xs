run.job "Create Google Calendar Event" {
  main = {
    name: "create_calendar_event"
    input: {
      summary: "Meeting with Team"
      description: "Weekly sync meeting"
      start_time: "2026-02-20T10:00:00-08:00"
      end_time: "2026-02-20T11:00:00-08:00"
      attendees: ["team@example.com"]
    }
  }
  env = ["GOOGLE_CALENDAR_API_KEY", "GOOGLE_CALENDAR_ID"]
}
