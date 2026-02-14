run.job "Cloudflare Purge Cache" {
  main = {
    name: "purge_cache"
    input: {
      zone_id: "your-zone-id-here"
      urls: ["https://example.com/page1", "https://example.com/page2"]
      purge_everything: false
    }
  }
  env = ["CLOUDFLARE_API_TOKEN"]
}
