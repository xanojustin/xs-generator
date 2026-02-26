run.job "Distribute Candies" {
  main = {
    name: "distribute_candies"
    input: {
      candy_types: [1, 1, 2, 2, 3, 3]
    }
  }
}
