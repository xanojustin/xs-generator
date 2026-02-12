table processed_charges {
  auth = false
  schema {
    int id
    text charge_id
    int amount
    text currency
    text customer_email?
    text description?
    text status
    int created_at
    timestamp processed_at?=now
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree|unique", field: [{name: "charge_id"}]}
  ]
  items = []
}