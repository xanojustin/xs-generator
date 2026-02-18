table payment_log {
  auth = false
  schema {
    int id
    text payment_id?
    text reference_id?
    decimal amount
    text currency
    text status
    text receipt_url?
    text error_message?
    timestamp created_at?=now
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "payment_id"}]},
    {type: "btree", field: [{name: "reference_id"}]},
    {type: "btree", field: [{name: "created_at"}]}
  ]
  items = []
}
