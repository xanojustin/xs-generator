table subscriber_log {
  auth = false
  schema {
    int id
    text email
    text profile_id?
    text list_id
    text first_name?
    text last_name?
    text status
    text error_message?
    timestamp created_at?=now
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "email"}]},
    {type: "btree", field: [{name: "list_id"}]},
    {type: "btree", field: [{name: "profile_id"}]},
    {type: "btree", field: [{name: "created_at"}]}
  ]
  items = []
}