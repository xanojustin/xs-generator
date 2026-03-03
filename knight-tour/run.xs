run.job "Knights Tour Solver" {
  main = {
    name: "knight_tour",
    input: {
      n: 5,
      start_row: 0,
      start_col: 0
    }
  }
}
