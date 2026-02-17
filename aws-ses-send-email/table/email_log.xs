table email_log {
  auth = false
  schema {
    int id
    timestamp sent_at?=now
    text to_email
    text to_name?
    text from_email
    text subject
    text message_id?
    text status
    text error_message?
    text aws_region?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "sent_at"}]}
    {type: "btree", field: [{name: "to_email"}]}
    {type: "btree", field: [{name: "status"}]}
  ]
  items = []
}
