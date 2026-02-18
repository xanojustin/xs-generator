run.job "DeepL Translate Text" {
  main = {
    name: "translate_text"
    input: {
      text: "Hello, world!"
      target_lang: "ES"
      source_lang: "EN"
    }
  }
  env = ["DEEPL_API_KEY"]
}
