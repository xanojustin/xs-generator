run.job "Firebase Create User" {
  main = {
    name: "create_firebase_user"
    input: {
      email: "newuser@example.com"
      password: "SecurePass123!"
      display_name: "New User"
    }
  }
  env = ["FIREBASE_API_KEY", "FIREBASE_PROJECT_ID"]
}
