// Run job to test the minimum-absolute-difference-in-bst function
run.job "Test Minimum Absolute Difference in BST" {
  main = {
    name: "minimum_absolute_difference_in_bst"
    input: {
      root: {
        val: 4
        left: {
          val: 2
          left: { val: 1 }
          right: { val: 3 }
        }
        right: {
          val: 6
        }
      }
    }
  }
}
