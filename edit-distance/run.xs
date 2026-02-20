// Run job to test the edit-distance function
// Tests various string pairs to verify the Levenshtein distance algorithm
run.job "Test Edit Distance" {
  main = {
    name: "edit-distance"
    input: {
      str1: "kitten"
      str2: "sitting"
    }
  }
}
