// Run job to test the sort_the_people function
// Sort the People: Sort names by corresponding heights in descending order
run.job "Test Sort The People" {
  main = {
    name: "sort_the_people"
    input: {
      names: ["Alice", "Bob", "Charlie", "David"]
      heights: [165, 180, 175, 160]
    }
  }
}
