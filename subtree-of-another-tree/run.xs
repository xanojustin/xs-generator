run.job "Subtree of Another Tree" {
  main = {
    name: "is_subtree"
    input: {
      root: {
        val: 3
        left: {
          val: 4
          left: { val: 1 }
          right: { val: 2 }
        }
        right: {
          val: 5
        }
      }
      subRoot: {
        val: 4
        left: { val: 1 }
        right: { val: 2 }
      }
    }
  }
}
