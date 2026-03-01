// Table to store hit timestamps for the Design Hit Counter exercise
table hits {
  auth = false
  schema {
    int id
    int timestamp
    timestamp created_at?=now
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "timestamp"}]}
  ]
  items = []
}
