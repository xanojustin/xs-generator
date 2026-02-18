table sms_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text to_number
    text from_number
    text message_body
    text twilio_sid?
    text status
    text error_message?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "twilio_sid"}]}
    {type: "btree", field: [{name: "to_number"}]}
    {type: "btree", field: [{name: "status"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}
