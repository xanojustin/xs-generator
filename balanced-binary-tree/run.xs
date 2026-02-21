// Run job to test the is_balanced function
// Balanced Binary Tree: Check if a binary tree is height-balanced
run.job "Test Balanced Binary Tree" {
  main = {
    name: "is_balanced"
    input: {
      root: {
        val: 3,
        left: {
          val: 9,
          left: null,
          right: null
        },
        right: {
          val: 20,
          left: {
            val: 15,
            left: null,
            right: null
          },
          right: {
            val: 7,
            left: null,
            right: null
          }
        }
      }
    }
  }
}
