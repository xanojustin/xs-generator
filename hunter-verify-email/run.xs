run.job "Hunter Email Verification" {
  main = {
    name: "verify_email"
    input: {
      email: "test@example.com"
    }
  }
  env = ["hunter_api_key"]
}
