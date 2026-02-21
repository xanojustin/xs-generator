run.job "Merge Intervals Test" {
  main = {
    name: "merge_intervals"
    input: {
      intervals: [
        {start: 1, end: 3},
        {start: 2, end: 6},
        {start: 8, end: 10},
        {start: 15, end: 18}
      ]
    }
  }
}
