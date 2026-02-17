run.job "ConvertKit Add Subscriber" {
  main = {
    name: "convertkit_add_subscriber"
    input: {
      email: "test@example.com"
      first_name: "Test"
      tags_json: "[]"
    }
  }
  env = ["convertkit_api_key"]
}
