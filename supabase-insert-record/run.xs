run.job "Supabase Insert Record" {
  main = {
    name: "supabase_insert_record"
    input: {
      table: "users"
      data: {
        email: "user@example.com"
        name: "John Doe"
        status: "active"
      }
      conflict_resolution: "error"
      returning_columns: ["id", "email", "name", "created_at"]
    }
  }
  env = ["SUPABASE_URL", "SUPABASE_ANON_KEY", "SUPABASE_SERVICE_ROLE_KEY"]
}
