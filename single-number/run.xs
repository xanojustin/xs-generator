// Run job to test the single_number function
// Single Number: Find the element that appears only once
// where every other element appears twice
run.job "Test Single Number" {
  main = {
    name: "single_number"
    input: {
      nums: [4, 1, 2, 1, 2]
    }
  }
}
