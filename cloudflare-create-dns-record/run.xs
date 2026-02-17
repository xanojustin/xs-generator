run.job "Cloudflare Create DNS Record" {
  main = {
    name: "create_dns_record"
    input: {
      zone_id: ""
      record_type: "A"
      name: ""
      content: ""
      ttl: 1
      proxied: true
    }
  }
  env = ["cloudflare_api_token", "cloudflare_account_id"]
}
