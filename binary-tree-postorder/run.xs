// Run job to test the binary_tree_postorder function
// Binary Tree Post-Order Traversal: Visit left subtree, right subtree, then root
// Tree structure:
//       1
//      / \
//     2   3
//    / \
//   4   5
// Post-order: 4, 5, 2, 3, 1
run.job "Test Binary Tree Post-Order Traversal" {
  main = {
    name: "binary_tree_postorder"
    input: {
      nodes: [
        { value: 1, left: 1, right: 2 }
        { value: 2, left: 3, right: 4 }
        { value: 3, left: null, right: null }
        { value: 4, left: null, right: null }
        { value: 5, left: null, right: null }
      ]
      root_index: 0
    }
  }
}
