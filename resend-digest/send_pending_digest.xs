task "send_pending_digest" {
  description = "Send daily digest emails to users with pending notifications via Resend every 30 minutes"
  stack {
    // Get users with digest enabled
    db.query "user" {
      where = $db.user.digest_enabled == true
    } as $users

    foreach ($users) {
      each as $user {
        // Get unsent notifications from last 30 minutes
        var $thirty_mins_ago { value = now|transform_timestamp:"-30 minutes" }
        
        db.query "notification" {
          where = $db.notification.user_id == $user.id && $db.notification.sent == false && $db.notification.created_at >= $thirty_mins_ago
        } as $notifications

        conditional {
          if (($notifications|count) > 0) {
            // Build email body
            var $email_body {
              value = "Hello " ~ $user.name ~ ",\n\nYou have " ~ ($notifications|count) ~ " new notification(s):\n\n" ~ ($notifications|map:"- " ~ $$.message|join:"\n") ~ "\n\n---\nThis is an automated digest from our system."
            }

            // Send via Resend
            api.request {
              url = "https://api.resend.com/emails"
              method = "POST"
              headers = [
                "Content-Type: application/json",
                "Authorization: Bearer " ~ $env.RESEND_API_KEY
              ]
              params = {
                from: "notifications@example.com",
                to: $user.email,
                subject: "You have " ~ ($notifications|count) ~ " new notification(s)",
                text: $email_body
              }
            } as $email_result

            // Check if email was sent successfully
            conditional {
              if ($email_result.response.status == 200) {
                // Mark notifications as sent
                foreach ($notifications) {
                  each as $notification {
                    db.edit "notification" {
                      field_name = "id"
                      field_value = $notification.id
                      data = { sent: true, sent_at: now }
                    }
                  }
                }
                debug.log { value = "Digest sent to " ~ $user.email }
              }
              else {
                debug.log { value = "Failed to send digest to " ~ $user.email ~ ": " ~ $email_result.response.result }
              }
            }
          }
        }
      }
    }
  }
  schedule = [{starts_on: 2026-02-12 18:00:00+0000, freq: 1800}]
}
