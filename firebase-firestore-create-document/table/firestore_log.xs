table "firestore_log" {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text operation
    text collection
    text document_id
    text request_data
    int response_status
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "created_at"}]},
    {type: "btree", field: [{name: "collection"}]}
  ]
  items = []
}
