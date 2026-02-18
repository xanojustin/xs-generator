table charge_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text stripe_payment_intent_id?
    int amount
    text currency
    text customer_email
    text description
    text status
    text error_message?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "stripe_payment_intent_id"}]}
    {type: "btree", field: [{name: "customer_email"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}
