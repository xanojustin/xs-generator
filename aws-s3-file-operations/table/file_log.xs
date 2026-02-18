table file_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text operation
    text bucket
    text prefix?
    text file_key?
    int file_count?
    int existing_count?
    text uploaded_file?
    bool success?
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "created_at"}]},
    {type: "btree", field: [{name: "operation"}]},
    {type: "btree", field: [{name: "bucket"}]}
  ]
  items = []
}
