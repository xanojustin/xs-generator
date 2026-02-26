// Run job entry point - calls the beautiful arrangement counter function
run.job "Test Beautiful Arrangement" {
  main = {
    name: "count-beautiful-arrangements"
    input: {
      n: 2
    }
  }
}
