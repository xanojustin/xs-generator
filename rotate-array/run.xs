// Run job to test the rotate_array function
run.job "Test Rotate Array" {
  main = {
    name: "rotate_array"
    input: {
      arr: [1, 2, 3, 4, 5]
      k: 2
    }
  }
}
