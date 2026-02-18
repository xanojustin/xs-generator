run.job "Webflow Create CMS Item" {
  main = {
    name: "create_webflow_cms_item"
    input: {
      collection_id: "",
      item_name: "",
      slug: "",
      fields: {}
    }
  }
  env = ["webflow_api_token", "webflow_site_id"]
}
