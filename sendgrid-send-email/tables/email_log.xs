table email_log {
  auth = false
  schema {
    int id
    timestamp sent_at?=now
    text to_email
    text subject
    text status
    text? error_message
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "index", field: [{name: "sent_at"}]},
    {type: "index", field: [{name: "to_email"}]}
  ]
  items = []
}