run.job "HubSpot Create Contact" {
  main = {
    name: "hubspot_create_contact"
    input: {
      email: "contact@example.com"
      firstname: "Jane"
      lastname: "Doe"
      phone: "+1-555-123-4567"
      company: "Acme Inc"
      jobtitle: "Software Engineer"
      lifecyclestage: "subscriber"
    }
  }
  env = ["hubspot_access_token"]
}
