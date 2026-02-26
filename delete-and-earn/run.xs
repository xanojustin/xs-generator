// Run job to test the delete-and-earn function
run.job "Delete and Earn Test" {
  main = {
    name: "delete-and-earn"
    input: {
      nums: [3, 4, 2]
    }
  }
}
