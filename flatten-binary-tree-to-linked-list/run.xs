run.job "Flatten Binary Tree to Linked List" {
  main = {
    name: "flatten_tree"
    input: {
      tree: {
        val: 1
        left: {
          val: 2
          left: { val: 3, left: null, right: null }
          right: { val: 4, left: null, right: null }
        }
        right: {
          val: 5
          left: null
          right: { val: 6, left: null, right: null }
        }
      }
    }
  }
}
