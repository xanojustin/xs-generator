run.job "Auth0 Create User" {
  main = {
    name: "create_auth0_user"
    input: {
      email: "newuser@example.com"
      password: "SecureTempPass123!"
      connection: "Username-Password-Authentication"
      verify_email: true
      user_metadata: {
        first_name: "New"
        last_name: "User"
        signup_source: "xano_run_job"
      }
      app_metadata: {
        plan: "free"
        roles: ["user"]
      }
    }
  }
  env = ["AUTH0_DOMAIN", "AUTH0_MANAGEMENT_TOKEN"]
}
