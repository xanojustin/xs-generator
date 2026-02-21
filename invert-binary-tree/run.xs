run.job "Invert Binary Tree" {
  main = {
    name: "invert_binary_tree"
    input: {
      tree: {
        val: 4
        left: {
          val: 2
          left: { val: 1 }
          right: { val: 3 }
        }
        right: {
          val: 7
          left: { val: 6 }
          right: { val: 9 }
        }
      }
    }
  }
}
