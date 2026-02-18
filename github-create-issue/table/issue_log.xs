table issue_log {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text repo_owner
    text repo_name
    int issue_number?
    text issue_title
    text issue_url?
    text github_issue_id?
    text status?="success"
    text error_message?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "repo_owner"}]}
    {type: "btree", field: [{name: "repo_name"}]}
    {type: "btree", field: [{name: "issue_number"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}
