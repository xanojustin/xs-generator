table webhook_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text content
    text username
    text avatar_url?
    int http_status
    text status
    text error_message?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "status"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}