// Run job to test the path sum function
run.job "Test Path Sum" {
  main = {
    name: "path_sum"
    input: {
      tree: {
        val: 5,
        left: {
          val: 4,
          left: {
            val: 11,
            left: { val: 7 },
            right: { val: 2 }
          }
        },
        right: {
          val: 8,
          left: { val: 13 },
          right: {
            val: 4,
            right: { val: 1 }
          }
        }
      }
      target_sum: 22
    }
  }
}
