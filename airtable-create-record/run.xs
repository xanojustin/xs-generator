run.job "Airtable Create Record" {
  main = {
    name: "create_airtable_record"
    input: {
      base_id: ""
      table_name: ""
      fields: {}
    }
  }
  env = ["airtable_api_key"]
}
