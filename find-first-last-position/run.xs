run.job "Find First and Last Position Test" {
  main = {
    name: "find_first_last_position"
    input: {
      nums: [5, 7, 7, 8, 8, 10]
      target: 8
    }
  }
}
