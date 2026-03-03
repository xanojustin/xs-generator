// Run job to test the path_sum_ii function
// Path Sum II: Find all root-to-leaf paths where sum equals target
run.job "Test Path Sum II" {
  main = {
    name: "path_sum_ii"
    input: {
      root: {
        val: 5
        left: {
          val: 4
          left: {
            val: 11
            left: { val: 7 }
            right: { val: 2 }
          }
        }
        right: {
          val: 8
          left: { val: 13 }
          right: {
            val: 4
            left: { val: 5 }
            right: { val: 1 }
          }
        }
      }
      target_sum: 22
    }
  }
}
