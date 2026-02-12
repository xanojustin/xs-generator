table payment_intents {
  auth = false
  schema {
    int id
    text stripe_id
    int amount
    text currency
    text status
    text client_secret
    text description?
    timestamp created_at?=now
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree|unique", field: [{name: "stripe_id"}]}
  ]
  items = []
}
