run.job "Amplitude Track Event" {
  main = {
    name: "track_event"
    input: {
      event_type: "User Signup"
      user_id: "user_12345"
      event_properties: {
        source: "landing_page"
        campaign: "spring_2024"
        plan: "pro"
      }
      user_properties: {
        signup_date: "2024-01-15"
        referrer: "google"
      }
      platform: "Web"
      os_name: "macOS"
      os_version: "14.0"
      country: "US"
      language: "en"
    }
  }
  env = ["AMPLITUDE_API_KEY"]
}
