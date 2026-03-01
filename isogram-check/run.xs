// Run job to test the is_isogram function
// Isogram Check: Determine if a word or phrase has no repeating letters
run.job "Test Isogram Check" {
  main = {
    name: "is_isogram"
    input: {
      text: "subdermatoglyphic"
    }
  }
}
