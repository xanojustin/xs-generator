run.job "Supabase Insert Record" {
  main = {
    name: "supabase_insert_record"
    input: {
      table_name: "users"
      data: {
        name: "Jane Doe"
        email: "jane@example.com"
        role: "customer"
      }
    }
  }
  env = ["supabase_url", "supabase_service_key"]
}
