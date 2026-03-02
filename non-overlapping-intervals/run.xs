// Run job to test the non-overlapping-intervals function
run.job "Non-overlapping Intervals Test" {
  main = {
    name: "non_overlapping_intervals"
    input: {
      intervals: [
        {start: 1, end: 2},
        {start: 2, end: 3},
        {start: 3, end: 4},
        {start: 1, end: 3}
      ]
    }
  }
}
