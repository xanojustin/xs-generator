// Run job to test the house-robber-iii function
run.job "Test House Robber III" {
  main = {
    name: "house-robber-iii"
    input: {
      tree: {
        val: 3
        left: {
          val: 2
          left: null
          right: {
            val: 3
            left: null
            right: null
          }
        }
        right: {
          val: 3
          left: null
          right: {
            val: 1
            left: null
            right: null
          }
        }
      }
    }
  }
}
