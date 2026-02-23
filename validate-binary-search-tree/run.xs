run.job "Validate BST Tests" {
  main = {
    name: "validate_bst"
    input: {
      tree: {
        val: 5
        left: {
          val: 3
          left: { val: 1 }
          right: { val: 4 }
        }
        right: {
          val: 7
          left: { val: 6 }
          right: { val: 8 }
        }
      }
    }
  }
}
