table message_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text channel
    text message
    text username
    text slack_timestamp?
    text slack_channel_id?
    text status
    text error_message?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "channel"}]}
    {type: "btree", field: [{name: "status"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}
