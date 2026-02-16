run.job "Cal.com Create Booking" {
  main = {
    name: "create_booking"
    input: {
      event_type_id: 0
      start_time: "2026-02-20T14:00:00Z"
      attendee: {
        name: "John Doe"
        email: "john@example.com"
        time_zone: "America/Los_Angeles"
      }
    }
  }
  env = ["CALCOM_API_KEY", "CALCOM_BASE_URL"]
}
