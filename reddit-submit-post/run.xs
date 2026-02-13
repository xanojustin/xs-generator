run.job "Reddit Submit Post" {
  main = {
    name: "reddit_submit_post"
    input: {
      subreddit: "xano"
      title: "Just discovered XanoScript - it's like backend development made simple!"
      content: "I've been building backend automations with XanoScript and I'm impressed by how clean the syntax is. Anyone else using it for their projects?"
      kind: "self"
      nsfw: false
      spoiler: false
    }
  }
  env = ["reddit_client_id", "reddit_client_secret", "reddit_username", "reddit_password"]
}
