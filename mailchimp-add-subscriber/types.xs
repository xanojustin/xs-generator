// Input Types for Mailchimp Add Subscriber
// ========================================

// Subscriber Input
type SubscriberInput {
  text email              // Subscriber email address (required)
  text first_name?        // Subscriber first name (optional)
  text last_name?         // Subscriber last name (optional)
  text audience_id        // Mailchimp audience/list ID (required)
}

// API Configuration
type ApiConfig {
  text api_key            // Mailchimp API key (from env)
  text server_prefix      // Mailchimp server prefix (from env, e.g., "us1", "us14")
}

// Merge Fields (Mailchimp's standard fields)
type MergeFields {
  text? FNAME             // First name field
  text? LNAME             // Last name field
}

// Request Payload to Mailchimp API
type MailchimpRequestPayload {
  text email_address      // Email to subscribe
  text status = "subscribed"  // Subscription status
  MergeFields merge_fields?   // Optional merge fields
}

// Response Types
// ==============

// Success Response from Mailchimp API
type MailchimpSubscriberResponse {
  text id                 // Unique subscriber ID (MD5 hash of email)
  text email_address      // Subscriber email
  text unique_email_id    // Unique email identifier
  text contact_id         // Contact ID
  text status             // Status: subscribed, unsubscribed, cleaned, pending
  text? unsubscribe_reason
  MergeFields merge_fields
  text list_id            // Audience/list ID
  timestamp timestamp_opt // Timestamp of opt-in
  timestamp last_changed  // Last modification timestamp
}

// Error Response
type ErrorResponse {
  text name               // Error type name
  text message            // Error message
  int status_code         // HTTP status code
  object? details         // Additional error details
}

// Function Output
type AddSubscriberOutput {
  bool success            // Whether the operation succeeded
  MailchimpSubscriberResponse? subscriber  // Subscriber data on success
  ErrorResponse? error    // Error details on failure
  text? debug_info        // Debug information
}