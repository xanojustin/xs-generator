run.job "Firebase Firestore Create Document" {
  main = {
    name: "create_firestore_document"
    input: {
      collection: "users"
      document_data: {
        name: "John Doe"
        email: "john.doe@example.com"
        created_at: "2025-01-15T10:30:00Z"
        status: "active"
      }
    }
  }
  env = ["firebase_project_id", "firebase_auth_token"]
}
