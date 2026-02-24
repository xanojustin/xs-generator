// Run job to test the insert_interval function
run.job "Insert Interval Test" {
  main = {
    name: "insert_interval"
    input: {
      intervals: [
        {start: 1, end: 3},
        {start: 6, end: 9}
      ]
      new_interval: {start: 2, end: 5}
    }
  }
}
