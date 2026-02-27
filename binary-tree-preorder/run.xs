// Run job to test the binary_tree_preorder function
// Binary Tree Pre-Order Traversal: Visit root, left subtree, then right subtree
// Tree structure:
//       1
//      / \
//     2   3
//    / \
//   4   5
// Pre-order: 1, 2, 4, 5, 3
run.job "Test Binary Tree Pre-Order Traversal" {
  main = {
    name: "binary_tree_preorder"
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
