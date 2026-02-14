run.job "Translate Text with DeepL" {
  main = {
    name: "translate_text"
    input: {
      text: "Hello, world!"
      target_lang: "ES"
      source_lang: "EN"
    }
  }
  env = ["deepl_api_key"]
}