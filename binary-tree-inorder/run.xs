// Run job to test the binary_tree_inorder function
// Binary Tree In-Order Traversal: Visit left subtree, root, then right subtree
// Tree structure:
//       1
//      / \
//     2   3
//    / \
//   4   5
// In-order: 4, 2, 5, 1, 3
run.job "Test Binary Tree In-Order Traversal" {
  main = {
    name: "binary_tree_inorder"
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
