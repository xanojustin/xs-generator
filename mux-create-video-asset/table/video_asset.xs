table "video_asset" {
  auth = false
  schema {
    int id
    text mux_asset_id
    text title
    text source_url
    text playback_id
    text status
    timestamp created_at?=now
    timestamp updated_at?
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "btree", field: [{name: "mux_asset_id"}]},
    {type: "btree", field: [{name: "playback_id"}]}
  ]
  items = []
}