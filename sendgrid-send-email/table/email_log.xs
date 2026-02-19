table email_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text recipient
    text subject
    timestamp sent_at
    text status
    text provider
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
  ]
}
