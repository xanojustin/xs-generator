// Run job to test the UTF-8 validation function
// Tests: Valid 2-byte char followed by 1-byte char
run.job "Test UTF8 Validation" {
  main = {
    name: "utf8_validation"
    input: {
      data: [197, 130, 1]
    }
  }
}
