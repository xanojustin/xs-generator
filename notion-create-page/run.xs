run.job "Notion Create Page" {
  main = {
    name: "create_page"
    input: {
      database_id: "your-database-id-here"
      title: "Hello from Xano!"
      content: "This page was created by a Xano Run Job."
    }
  }
  env = ["NOTION_API_KEY", "NOTION_DATABASE_ID"]
}
