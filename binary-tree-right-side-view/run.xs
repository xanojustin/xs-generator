// Run job to test the binary_tree_right_side_view function
// Binary Tree Right Side View: Return values visible from the right side, top to bottom
// Tree structure:
//       1
//      / \
//     2   3
//      \   \
//       5   4
// Right side view: 1, 3, 4 (standing on right, you see rightmost node at each level)
run.job "Test Binary Tree Right Side View" {
  main = {
    name: "binary_tree_right_side_view"
    input: {
      nodes: [
        { value: 1, left: 1, right: 2 }
        { value: 2, left: null, right: 3 }
        { value: 3, left: null, right: 4 }
        { value: 5, left: null, right: null }
        { value: 4, left: null, right: null }
      ]
      root_index: 0
    }
  }
}
