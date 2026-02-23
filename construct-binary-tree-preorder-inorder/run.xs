// Run job to test the build_tree function
// Constructs a binary tree from preorder and inorder traversals
run.job "Test Build Tree" {
  main = {
    name: "build_tree"
    input: {
      preorder: [3, 9, 20, 15, 7]
      inorder: [9, 3, 15, 20, 7]
    }
  }
}
