run.job "Create Notion Page" {
  main = {
    name: "create_notion_page"
    input: {
      database_id: "your-database-id-here"
      title: "My New Notion Page"
      content: "This page was created via the Notion API using Xano Run Jobs! 🚀"
      tags: ["Xano", "Automation", "API"]
      properties: {}
    }
  }
  env = ["NOTION_API_KEY"]
}
