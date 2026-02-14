run.job "Notion Create Page" {
  main = {
    name: "create_notion_page"
    input: {
      database_id: "your-database-id-here"
      title: "Page Created from Xano"
      content: "This page was created using the Notion API via Xano Run Job."
    }
  }
  env = ["notion_api_key"]
}
