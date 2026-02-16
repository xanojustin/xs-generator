table conversion {
  auth = false
  schema {
    int id
    text job_id
    text input_url
    text output_format
    text output_filename
    text output_url
    text status
    timestamp created_at?=now
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "job_id"}]},
    {type: "btree", field: [{name: "created_at"}]}
  ]
  items = []
}
