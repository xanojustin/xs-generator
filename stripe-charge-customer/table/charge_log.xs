table charge_log {
  auth = false
  schema {
    int id
    text charge_id?
    text customer_id
    decimal amount
    text currency
    text status
    text error_message?
    timestamp created_at?=now
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "customer_id"}]},
    {type: "btree", field: [{name: "charge_id"}]},
    {type: "btree", field: [{name: "created_at"}]}
  ]
  items = []
}
