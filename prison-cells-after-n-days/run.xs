run.job "Prison Cells After N Days" {
  main = {
    name: "prison_cells"
    input: {
      cells: [0, 1, 0, 1, 1, 0, 0, 1]
      n: 7
    }
  }
}
