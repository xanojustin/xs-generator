table wallet_query {
  auth = false
  schema {
    int id
    timestamp queried_at?=now
    text wallet_address
    float balance_eth
  }
  index = [
    {type: "primary", field: [{name: "id"}]},
    {type: "index", field: [{name: "wallet_address"}]},
    {type: "index", field: [{name: "queried_at"}]}
  ]
  items = []
}
