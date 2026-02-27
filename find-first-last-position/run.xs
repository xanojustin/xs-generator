// Run job to test the find_first_last_position function
// Find First and Last Position: Find starting and ending positions of a target value
run.job "Test Find First and Last Position" {
  main = {
    name: "find_first_last_position"
    input: {
      nums: [5, 7, 7, 8, 8, 10]
      target: 8
    }
  }
}
