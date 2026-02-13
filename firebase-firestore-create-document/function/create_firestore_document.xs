function "create_firestore_document" {
  description = "Creates a new document in Firebase Firestore via REST API"
  input {
    text collection {
      description = "Firestore collection name"
    }
    object document_data {
      description = "Document data to create"
    }
  }
  stack {
    // Validate required environment variables
    precondition ($env.firebase_project_id != null && $env.firebase_project_id != "") {
      error_type = "inputerror"
      error = "Missing required environment variable: firebase_project_id"
    }
    
    precondition ($env.firebase_auth_token != null && $env.firebase_auth_token != "") {
      error_type = "inputerror"
      error = "Missing required environment variable: firebase_auth_token"
    }
    
    // Validate input
    precondition ($input.collection != "") {
      error_type = "inputerror"
      error = "Collection name cannot be empty"
    }
    
    precondition ($input.document_data != null) {
      error_type = "inputerror"
      error = "Document data is required"
    }
    
    // Build the Firestore REST API URL
    var $base_url {
      value = "https://firestore.googleapis.com/v1/projects/" ~ $env.firebase_project_id ~ "/databases/(default)/documents/" ~ $input.collection
    }
    
    // Convert document data to Firestore format (fields with type annotations)
    function.run "format_firestore_fields" {
      input = { data: $input.document_data }
    } as $formatted_fields
    
    // Prepare request body
    var $request_body {
      value = { fields: $formatted_fields }
    }
    
    // Make the API request to Firestore
    api.request {
      url = $base_url
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.firebase_auth_token
      ]
      params = $request_body
      timeout = 30
    } as $api_response
    
    // Check for successful response
    precondition ($api_response.response.status >= 200 && $api_response.response.status < 300) {
      error_type = "standard"
      error = "Firestore API request failed with status: " ~ $api_response.response.status|to_text
    }
    
    // Extract document info from response
    var $created_document {
      value = $api_response.response.result
    }
    
    var $document_id {
      value = $created_document.name|split:"/"|last
    }
    
    // Log the operation to local table
    db.add "firestore_log" {
      data = {
        operation: "create",
        collection: $input.collection,
        document_id: $document_id,
        request_data: $input.document_data|json_encode,
        response_status: $api_response.response.status,
        created_at: now
      }
    } as $log_entry
    
    // Prepare success response
    var $result {
      value = {
        success: true,
        document_id: $document_id,
        collection: $input.collection,
        document_path: $created_document.name,
        create_time: $created_document.createTime,
        log_entry_id: $log_entry.id
      }
    }
  }
  response = $result
}
