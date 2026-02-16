run.job "CloudConvert File Conversion" {
  main = {
    name: "convert_file"
    input: {
      input_url: "https://example.com/sample-document.docx"
      output_format: "pdf"
      filename: "converted-document"
    }
  }
  env = ["cloudconvert_api_key"]
}
