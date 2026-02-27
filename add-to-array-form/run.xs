// Run job to test the add_to_array_form function
run.job "Test Add to Array Form" {
  main = {
    name: "add_to_array_form"
    input: {
      num: [1, 2, 0, 0]
      k: 34
    }
  }
}
