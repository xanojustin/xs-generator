run.job "Get Figma File Comments" {
  main = {
    name: "get_figma_comments"
    input: {
      file_key: "REPLACE_WITH_FIGMA_FILE_KEY"
    }
  }
  env = ["figma_token"]
}
