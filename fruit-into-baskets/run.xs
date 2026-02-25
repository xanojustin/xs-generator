// Run job to test the fruit_into_baskets function
// Fruit Into Baskets: Find maximum fruits collected with at most 2 types
run.job "Test Fruit Into Baskets" {
  main = {
    name: "fruit_into_baskets"
    input: {
      fruits: [1, 2, 1]
    }
  }
}
