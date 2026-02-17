run.job "HubSpot Create Contact" {
  main = {
    name: "create_hubspot_contact"
    input: {
      email: "example@company.com"
      first_name: "John"
      last_name: "Doe"
      company: "Acme Inc"
      job_title: "Software Engineer"
    }
  }
  env = ["HUBSPOT_ACCESS_TOKEN"]
}
