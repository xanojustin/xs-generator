run.job "Airtable Create Record" {
  main = {
    name: "airtable_create_record"
    input: {
      base_id: "appYOURBASEID"
      table_name: "Table%201"
      fields: {
        Name: "Test Record from Xano Run Job"
        Notes: "Created via XanoScript"
        Status: "In Progress"
      }
    }
  }
  env = ["airtable_api_key"]
}
