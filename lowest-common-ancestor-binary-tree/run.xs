// Run job to test the lowest_common_ancestor_binary_tree function
// Lowest Common Ancestor of a Binary Tree
// Finds the deepest node that has both p and q as descendants
//
// Tree structure for test:
//        3
//       / \
//      5   1
//     / \   \
//    6   2   0
//       / \
//      7   4
//
// LCA(5, 1) = 3
// LCA(5, 4) = 5
// LCA(6, 4) = 5
// LCA(7, 0) = 3
run.job "Test Lowest Common Ancestor Binary Tree" {
  main = {
    name: "lowest_common_ancestor_binary_tree"
    input: {
      nodes: [
        { value: 3, left: 1, right: 2 }
        { value: 5, left: 3, right: 4 }
        { value: 1, left: null, right: 5 }
        { value: 6, left: null, right: null }
        { value: 2, left: 6, right: 7 }
        { value: 0, left: null, right: null }
        { value: 7, left: null, right: null }
        { value: 4, left: null, right: null }
      ]
      root_index: 0
      p_value: 5
      q_value: 1
    }
  }
}
