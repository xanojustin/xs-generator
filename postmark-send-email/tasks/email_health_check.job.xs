task "email_health_check" {
  description = "Scheduled health check that sends a status email via Postmark"

  stack {
    api.request {
      description = "Send health check email via Postmark API"
      url = "https://api.postmarkapp.com/email"
      method = "POST"
      headers = [
        "Accept: application/json",
        "Content-Type: application/json",
        "X-Postmark-Server-Token: " ~ $env.postmark_api_key
      ]
      payload = {
        From: $env.postmark_sender_email,
        To: $env.postmark_alert_email,
        Subject: "[Health Check] System Status - HEALTHY",
        HtmlBody: "<html><body><h2 style='color: #2ecc71;'>✓ System Health Check</h2><p>All systems operational.</p></body></html>",
        TextBody: "System Health Check - All Systems Operational",
        Tag: "health-check"
      }
      timeout = 30
    } as $email_result

    debug.log {
      description = "Log health check email result"
      value = $email_result
    }
  }

  schedule = [
    {starts_on: "2025-02-12 10:00:00+0000", freq: 86400}
  ]
}
