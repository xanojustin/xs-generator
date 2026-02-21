// Run job to test the maximum_depth_binary_tree function
// Maximum Depth of Binary Tree: Find the number of nodes along the longest path
// 
// Test Tree 1 (Balanced):
//       3
//      / \
//     9  20
//       /  \
//      15   7
// Depth: 3
//
// Test Tree 2 (Left-heavy):
//     1
//    /
//   2
//  /
// 3
// Depth: 3
//
// Test Tree 3 (Single node):
//     1
// Depth: 1
//
// Test Tree 4 (Empty):
// null
// Depth: 0
run.job "Test Maximum Depth of Binary Tree" {
  main = {
    name: "maximum_depth_binary_tree"
    input: {
      // Balanced tree - depth 3
      tree: {
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
