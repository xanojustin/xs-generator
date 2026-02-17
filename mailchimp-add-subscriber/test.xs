function "test_cases" {
  description = "Test cases for Mailchimp Add Subscriber - see README for examples"
  input {}
  stack {
    // Test Case 1: Basic subscription
    // Input: { email: "john.doe@example.com", first_name: "John", last_name: "Doe", audience_id: "a1b2c3d4e5" }
    
    // Test Case 2: Email only
    // Input: { email: "jane.smith@example.com", first_name: "", last_name: "", audience_id: "a1b2c3d4e5" }
    
    // Test Case 3: Special characters
    // Input: { email: "josé@example.com", first_name: "José", last_name: "García", audience_id: "a1b2c3d4e5" }
    
    // Test Case 4: Invalid email (should fail)
    // Input: { email: "not-an-email", first_name: "Invalid", last_name: "Test", audience_id: "a1b2c3d4e5" }
    
    // Test Case 5: Missing audience (should fail)
    // Input: { email: "test@example.com", first_name: "Test", last_name: "User", audience_id: "" }
  }
  response = {}
}