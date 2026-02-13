run.job "Trello Create Card" {
  main = {
    name: "trello_create_card"
    input: {
      list_id: "your_list_id_here"
      card_name: "New Feature Request"
      card_description: "This card was created via Xano Run Job"
      due_date: ""
      labels: ""
    }
  }
  env = ["trello_api_key", "trello_api_token"]
}
