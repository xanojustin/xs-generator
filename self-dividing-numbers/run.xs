// Run job to test the self_dividing_numbers function
run.job "Test Self Dividing Numbers" {
  main = {
    name: "self_dividing_numbers"
    input: {
      left: 1
      right: 22
    }
  }
}
