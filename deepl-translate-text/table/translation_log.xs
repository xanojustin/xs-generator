table translation_log {
  auth = false
  schema {
    int id
    text source_text
    text translated_text?
    text source_lang?
    text target_lang
    text status
    text error_message?
    timestamp created_at?=now
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at"}]}
    {type: "btree", field: [{name: "status"}]}
  ]
  items = []
}
