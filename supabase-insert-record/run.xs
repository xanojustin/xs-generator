run.job "Supabase Insert Record" {
  main = {
    name: "supabase_insert"
    input: {
      table_name: "sync_log"
      data: {
        event: "test_insert"
        source: "xano_run_job"
      }
    }
  }
  env = ["supabase_url", "supabase_anon_key"]
}
