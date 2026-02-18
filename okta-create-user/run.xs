run.job "Create Okta User" {
  main = {
    name: "create_okta_user"
    input: {
      first_name: "John"
      last_name: "Doe"
      email: "john.doe@example.com"
      login: "john.doe@example.com"
      mobile_phone: ""
      activate: true
    }
  }
  env = ["OKTA_API_TOKEN", "OKTA_ORG_URL"]
}
