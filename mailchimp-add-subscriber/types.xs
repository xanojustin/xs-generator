function "type_definitions" {
  description = "Type definitions for Mailchimp Add Subscriber inputs and outputs"
  input {}
  stack {
    // Input Types:
    // - email: text (required) - Subscriber email address
    // - first_name: text (optional) - Subscriber first name
    // - last_name: text (optional) - Subscriber last name
    // - audience_id: text (required) - Mailchimp audience/list ID
    
    // Environment Variables:
    // - mailchimp_api_key: text (required) - Mailchimp API key
    // - mailchimp_server_prefix: text (required) - Server prefix (e.g., "us1")
    
    // Output Types:
    // On success: Mailchimp Member object with id, email_address, status, list_id, etc.
    // On failure: Error object with name, message, status_code
  }
  response = {}
}