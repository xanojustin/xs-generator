// Run job to test the count_and_say function
// Count and Say: Generate the nth term of the count-and-say sequence
run.job "Test Count and Say" {
  main = {
    name: "count_and_say"
    input: {
      n: 5
    }
  }
}
