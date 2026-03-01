run.job "Find Mode in BST Test" {
  main = {
    name: "find_mode_in_bst"
    input: {
      root: {
        val: 1
        right: {
          val: 2
          left: {
            val: 2
          }
        }
      }
    }
  }
}
