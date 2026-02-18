table plaid_log {
  auth = false
  schema {
    int id
    text operation
    text status
    text item_id?
    int account_count?
    text error_message?
    timestamp created_at?=now
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "operation"}]},
    {type: "btree", field: [{name: "status"}]},
    {type: "btree", field: [{name: "created_at"}]}
  ]
  items = []
}
