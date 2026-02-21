// Run job to test the binary_tree_level_order function
// Binary Tree Level Order Traversal: Returns nodes grouped by level (breadth-first)
// Tree structure:
//       1
//      / \
//     2   3
//    / \   \
//   4   5   6
// Level order: [[1], [2, 3], [4, 5, 6]]
run.job "Test Binary Tree Level Order Traversal" {
  main = {
    name: "binary_tree_level_order"
    input: {
      nodes: [
        { value: 1, left: 1, right: 2 }
        { value: 2, left: 3, right: 4 }
        { value: 3, left: null, right: 5 }
        { value: 4, left: null, right: null }
        { value: 5, left: null, right: null }
        { value: 6, left: null, right: null }
      ]
      root_index: 0
    }
  }
}
