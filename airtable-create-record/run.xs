run.job "Airtable Create Record" {
  main = {
    name: "create_record"
    input: {
      base_id: "YOUR_BASE_ID"
      table_name: "Tasks"
      fields: "{\"Name\":\"Sample task created by XanoScript\",\"Status\":\"To Do\",\"Priority\":\"Medium\"}"
    }
  }
  env = ["AIRTABLE_API_KEY"]
}
