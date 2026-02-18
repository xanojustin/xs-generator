table page_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text notion_page_id?
    text database_id
    text title
    text content?
    text url?
    text status
    text error_message?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "database_id"}]}
    {type: "btree", field: [{name: "status"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}
