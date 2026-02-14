run.job "Clearbit Enrich Company" {
  main = {
    name: "enrich_company"
    input: {
      domain: "stripe.com"
      enrich_type: "company"
    }
  }
  env = ["CLEARBIT_API_KEY"]
}
