// Run job to test the check_all_a_before_b function
// Checks if all 'a's appear before all 'b's in a string
run.job "Test Check All A Before B" {
  main = {
    name: "check_all_a_before_b"
    input: {
      s: "aaabbb"
    }
  }
}
