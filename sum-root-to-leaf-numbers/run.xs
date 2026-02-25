// Run job to test the Sum Root to Leaf Numbers function
run.job "Test Sum Root to Leaf Numbers" {
  main = {
    name: "sum_root_to_leaf"
    input: {
      tree: {
        val: 1,
        left: {
          val: 2,
          left: { val: 4 },
          right: { val: 5 }
        },
        right: {
          val: 3,
          left: { val: 6 },
          right: { val: 7 }
        }
      }
    }
  }
}
