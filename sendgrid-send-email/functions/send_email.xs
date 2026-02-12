function "send_email" {
  input {
    text to
    text subject
    text body
    text? from_name
  }
  stack {
    # Validate required inputs
    precondition {
      expression = $input.to != null && $input.to != ""
      message = "Recipient email (to) is required"
    }
    
    precondition {
      expression = $input.subject != null && $input.subject != ""
      message = "Subject is required"
    }
    
    # Set default from name if not provided
    set $from_name = $input.from_name ?? "Xano App"
    
    # Build SendGrid API payload
    set $sendgrid_payload = {
      personalizations: [
        {
          to: [
            { email: $input.to }
          ]
        }
      ],
      from: {
        email: env.SENDGRID_FROM_EMAIL,
        name: $from_name
      },
      subject: $input.subject,
      content: [
        {
          type: "text/plain",
          value: $input.body
        }
      ]
    }
    
    # Send email via SendGrid API
    request {
      url = "https://api.sendgrid.com/v3/mail/send"
      method = "POST"
      headers = {
        Authorization: "Bearer " + env.SENDGRID_API_KEY,
        Content-Type: "application/json"
      }
      body = $sendgrid_payload
    } as $response
    
    # Log the sent email to database
    db.add email_log {
      data = {
        to_email: $input.to,
        subject: $input.subject,
        sent_at: now,
        status: "sent"
      }
    } as $log_entry
  }
  
  response = {
    success: true
    message: "Email sent successfully to " + $input.to
    log_id: $log_entry.id
  }
}