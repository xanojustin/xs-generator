run.job "Create Sendbird User" {
  main = {
    name: "create_user"
    input: {
      user_id: "user_12345"
      nickname: "John Doe"
      profile_url: "https://example.com/avatar.jpg"
    }
  }
  env = ["SENDBIRD_API_TOKEN", "SENDBIRD_APP_ID"]
}
