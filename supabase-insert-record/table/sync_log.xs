table sync_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text event
    text source
    text status?="pending"
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
  ]
  items = []
}
