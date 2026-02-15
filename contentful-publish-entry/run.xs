run.job "Contentful Publish Entry" {
  main = {
    name: "publish_entry"
    input: {
      space_id: "your-space-id"
      environment: "master"
      content_type: "blogPost"
      entry_id: ""
      fields: {
        title: { "en-US": "My New Blog Post" }
        slug: { "en-US": "my-new-blog-post" }
        body: { "en-US": { nodeType: "document", data: {}, content: [] } }
      }
      publish: true
    }
  }
  env = ["CONTENTFUL_MANAGEMENT_TOKEN", "CONTENTFUL_SPACE_ID"]
}
