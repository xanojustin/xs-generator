// Run job to test the binary_tree_maximum_path_sum function
// Binary Tree Maximum Path Sum: Find the maximum path sum in a binary tree
run.job "Test Binary Tree Maximum Path Sum" {
  main = {
    name: "binary_tree_maximum_path_sum"
    input: {
      tree: {
        val: 1
        left: {
          val: 2
          left: null
          right: null
        }
        right: {
          val: 3
          left: null
          right: null
        }
      }
    }
  }
}
