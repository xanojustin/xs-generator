// Okta Create User Run Job
// Creates a user in Okta identity platform
run.job "Okta Create User" {
  main = {
    name: "create_okta_user"
    input: {
      first_name: "John"
      last_name: "Doe"
      email: "john.doe@example.com"
      activate: true
    }
  }
  env = ["OKTA_DOMAIN", "OKTA_API_TOKEN"]
}
