// Test Configuration for Mailchimp Add Subscriber
// =================================================
// This file contains sample input data for testing the run job

// Test Case 1: Basic subscription with minimal data
test "basic_subscription" {
  input = {
    email: "john.doe@example.com"
    first_name: "John"
    last_name: "Doe"
    audience_id: "a1b2c3d4e5"  // Replace with your actual audience ID
  }
}

// Test Case 2: Subscription with only email (no names)
test "email_only" {
  input = {
    email: "jane.smith@example.com"
    first_name: ""
    last_name: ""
    audience_id: "a1b2c3d4e5"
  }
}

// Test Case 3: Subscription with special characters in name
test "special_characters" {
  input = {
    email: "josé.garcía@example.com"
    first_name: "José"
    last_name: "García-Marquez"
    audience_id: "a1b2c3d4e5"
  }
}

// Test Case 4: Invalid email format (should fail)
test "invalid_email" {
  input = {
    email: "not-an-email"
    first_name: "Invalid"
    last_name: "Test"
    audience_id: "a1b2c3d4e5"
  }
}

// Test Case 5: Empty audience ID (should fail)
test "missing_audience" {
  input = {
    email: "test@example.com"
    first_name: "Test"
    last_name: "User"
    audience_id: ""
  }
}