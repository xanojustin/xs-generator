table deployment_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text project_id
    text deployment_id
    text target
    text state
    text url
    text error_message?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "project_id"}, {name: "created_at"}]}
  ]
  items = []
}
