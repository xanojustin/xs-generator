run.job "HubSpot Create Contact" {
  main = {
    name: "create_contact"
    input: {
      email: "test@example.com"
      firstname: "John"
      lastname: "Doe"
      company: "Acme Inc"
      phone: "+1-555-123-4567"
      jobtitle: "Software Engineer"
      lifecyclestage: "subscriber"
    }
  }
  env = ["HUBSPOT_ACCESS_TOKEN"]
}
