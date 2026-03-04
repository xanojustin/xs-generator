run.job "Time Needed to Inform All Employees Tests" {
  main = {
    name: "time_needed_to_inform"
    input: {
      n: 6
      headID: 2
      manager: [2, 2, -1, 0, 0, 1]
      informTime: [1, 1, 0, 0, 0, 0]
    }
  }
}
