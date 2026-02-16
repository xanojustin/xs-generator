run.job "Auth0 Create User" {
  main = {
    name: "create_auth0_user"
    input: {
      email: "user@example.com"
      password: "SecurePassword123!"
      connection: "Username-Password-Authentication"
      user_metadata: {}
      app_metadata: {}
    }
  }
  env = ["auth0_domain", "auth0_client_id", "auth0_client_secret"]
}
