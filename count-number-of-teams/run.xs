run.job "Count Number of Teams" {
  main = {
    name: "count_number_of_teams"
    input: {
      ratings: [2, 5, 3, 4, 1]
    }
  }
}
