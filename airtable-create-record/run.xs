run.job "Airtable Create Record" {
  main = {
    name: "airtable_create_record"
    input: {
      base_id: "appXXXXXXXXXXXXXX"
      table_name: "Tasks"
      fields: {
        "Task Name": "New Automated Task"
        "Status": "In Progress"
        "Priority": "High"
        "Due Date": "2026-02-15"
      }
    }
  }
  env = ["airtable_api_key"]
}