run.job "Dropbox Upload File" {
  main = {
    name: "upload_file"
    input: {
      file_path: "/test-folder/test-file.txt"
      file_content: "Hello from XanoScript!"
    }
  }
  env = ["DROPBOX_ACCESS_TOKEN"]
}
