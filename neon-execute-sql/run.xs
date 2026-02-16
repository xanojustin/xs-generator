run.job "Neon Execute SQL" {
  main = {
    name: "execute_sql"
    input: {
      query: "SELECT * FROM users LIMIT 10"
    }
  }
  env = ["neon_api_key", "neon_project_id", "neon_database_name"]
}
