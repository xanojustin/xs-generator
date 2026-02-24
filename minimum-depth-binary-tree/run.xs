// Run job to test the minimum_depth_binary_tree function
run.job "Test Minimum Depth Binary Tree" {
  main = {
    name: "minimum_depth_binary_tree"
    input: {
      root: {
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
