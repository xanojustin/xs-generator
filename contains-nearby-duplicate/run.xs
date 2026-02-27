run.job "Contains Nearby Duplicate Test" {
  main = {
    name: "contains_nearby_duplicate"
    input: {
      nums: [1, 2, 3, 1]
      k: 3
    }
  }
}
