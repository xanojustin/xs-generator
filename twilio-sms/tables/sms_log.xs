table sms_log {
  auth = false
  schema {
    int id
    text to_number
    text from_number
    text message_body
    text status
    text? twilio_sid
    timestamp sent_at?=now
    text? error_code
    text? error_message
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "to_number"}]},
    {type: "btree", field: [{name: "sent_at"}]},
    {type: "btree", field: [{name: "status"}]}
  ]
  items = []
}
