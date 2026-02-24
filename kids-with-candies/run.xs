// Run job to test the kidsWithCandies function
run.job "Test Kids With Candies" {
  main = {
    name: "kidsWithCandies"
    input: {
      candies: [2, 3, 5, 1, 3]
      extraCandies: 3
    }
  }
}
