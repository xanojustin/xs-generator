// Run job to test the diameter_of_binary_tree function
// Diameter of Binary Tree: Find the length of the longest path between any two nodes
run.job "Test Diameter of Binary Tree" {
  main = {
    name: "diameter_of_binary_tree"
    input: {
      tree: {
        val: 1
        left: {
          val: 2
          left: {
            val: 4
            left: null
            right: null
          }
          right: {
            val: 5
            left: null
            right: null
          }
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