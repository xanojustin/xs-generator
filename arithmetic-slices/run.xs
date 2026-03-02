// Run job for Arithmetic Slices exercise
run.job "Arithmetic Slices Counter" {
  main = {
    name: "arithmetic_slices"
    input: {
      nums: [1, 2, 3, 4]
    }
  }
}
