table event_log {
  auth = false
  schema {
    int id
    text event_type
    text account_id
    text event_data?
    text status
    int http_status?
    text error_message?
    timestamp created_at?=now
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "event_type"}]},
    {type: "btree", field: [{name: "account_id"}]},
    {type: "btree", field: [{name: "status"}]},
    {type: "btree", field: [{name: "created_at"}]}
  ]
  items = []
}
