run.job "Create Trello Card" {
  main = {
    name: "create_trello_card"
    input: {
      list_id: "YOUR_LIST_ID"
      card_name: "New Card from Xano"
      card_description: "This card was created via Xano Run Job"
    }
  }
  env = ["trello_api_key", "trello_api_token"]
}
