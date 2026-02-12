function "send_sms" {
  input {
    text to
    text message
  }
  stack {
    db.query sms_log {
      return = { type: "list" }
    } as $existing
    
    db.add sms_log {
      data = {
        to_number: $to
        from_number: "+1234567890"
        message_body: $message
        status: "queued"
        sent_at: now
      }
    } as $log_entry
  }
  response = {
    success: true
    message: "SMS queued for delivery"
    to: $to
    logged_id: $log_entry.id
  }
}
