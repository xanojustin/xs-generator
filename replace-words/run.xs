run.job "Replace Words Exercise" {
  main = {
    name: "replace_words"
    input: {
      dictionary: ["cat", "bat", "rat"]
      sentence: "the cattle was rattled by the battery"
    }
  }
}
