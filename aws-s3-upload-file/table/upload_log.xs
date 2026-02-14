table upload_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text file_path
    text content_type
    text status
    int http_status
    text message
    text s3_url
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "created_at"}]},
    {type: "btree", field: [{name: "status"}]}
  ]
  items = []
}
