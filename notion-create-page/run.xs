run.job "Notion Create Page" {
  main = {
    name: "create_page"
    input: {}
  }
  env = ["notion_api_key", "notion_database_id", "notion_page_title", "notion_page_content"]
}