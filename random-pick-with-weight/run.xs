// Random Pick with Weight - Run job
// Picks an index based on weighted probability using prefix sums and binary search
run.job "Test Random Pick With Weight" {
  main = {
    name: "random_pick_with_weight"
    input: {
      weights: [1, 3, 4, 2]
      num_picks: 10
    }
  }
}
