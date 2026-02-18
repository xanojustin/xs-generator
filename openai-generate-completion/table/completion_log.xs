table completion_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text prompt
    text model
    text completion?
    int prompt_tokens?
    int completion_tokens?
    int total_tokens?
    text status
    text error_message?
    int http_status?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "model"}]}
    {type: "btree", field: [{name: "status"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}
