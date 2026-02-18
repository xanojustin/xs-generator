table invoice_log {
  auth = false
  schema {
    int id
    text invoice_id?
    text doc_number?
    text customer_id
    text customer_name
    text customer_email?
    decimal total_amount
    text invoice_date
    text due_date
    text status
    text error_message?
    json qb_response?
    timestamp created_at?=now
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "invoice_id"}]},
    {type: "btree", field: [{name: "customer_id"}]},
    {type: "btree", field: [{name: "customer_name"}]},
    {type: "btree", field: [{name: "status"}]},
    {type: "btree", field: [{name: "created_at"}]}
  ]
  items = []
}
