table generation_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text model
    text prompt
    text response
    int total_duration?
    int load_duration?
    int prompt_eval_count?
    int eval_count?
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "created_at"}]},
    {type: "btree", field: [{name: "model"}]}
  ]
  items = []
}
