// Run job to test the magic index finder
// Tests various cases including happy path, edge cases, and boundary conditions
run.job "Magic Index Test" {
  main = {
    name: "magic_index"
    input: {
      nums: [-1, 0, 2, 4, 5]
    }
  }
}
