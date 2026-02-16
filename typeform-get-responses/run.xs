run.job "Typeform Get Responses" {
  main = {
    name: "get_form_responses"
    input: {
      form_id: "your-form-id-here"
      page_size: "10"
    }
  }
  env = ["TYPEFORM_API_KEY"]
}
