// Run job to test the sum_of_left_leaves function
run.job "Test Sum of Left Leaves" {
  main = {
    name: "sum_of_left_leaves"
    input: {
      tree: {
        val: 3
        left: {
          val: 9
          left: null
          right: null
        }
        right: {
          val: 20
          left: {
            val: 15
            left: null
            right: null
          }
          right: {
            val: 7
            left: null
            right: null
          }
        }
      }
    }
  }
}
