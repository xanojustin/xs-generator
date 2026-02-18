run.job "Clearbit Company Enrichment" {
  main = {
    name: "enrich_company"
    input: {
      domain: "stripe.com"
    }
  }
  env = ["clearbit_api_key"]
}
