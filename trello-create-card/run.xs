run.job "Trello Create Card" {
  main = {
    name: "create_card"
    input: {
      name: "New Task from Xano"
      description: "This card was created via XanoScript Run Job"
      list_id: "your_list_id_here"
    }
  }
  env = ["TRELLO_API_KEY", "TRELLO_TOKEN"]
}
