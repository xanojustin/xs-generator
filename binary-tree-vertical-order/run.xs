// Run job to test the vertical_order function
// Binary Tree Vertical Order Traversal: Group nodes by their vertical column
run.job "Test Binary Tree Vertical Order" {
  main = {
    name: "vertical_order"
    input: {
      root: {
        val: 3
        left: {
          val: 9
          left: null
          right: null
        }
        right: {
          val: 20
          left: {
            val: 15
            left: null
            right: null
          }
          right: {
            val: 7
            left: null
            right: null
          }
        }
      }
    }
  }
}
