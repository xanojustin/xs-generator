table incident_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text title
    text service_key
    text urgency
    text body?
    text dedup_key?
    text status?="success"
    text message?
    text error_message?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "service_key"}]}
    {type: "btree", field: [{name: "status"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}
