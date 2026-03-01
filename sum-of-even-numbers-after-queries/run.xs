// Run job to test sum_evens_after_queries function
run.job "Test Sum of Even Numbers After Queries" {
  main = {
    name: "sum_evens_after_queries"
    input: {
      nums: [1, 2, 3, 4]
      queries: [
        {val: 1, index: 0}
        {val: -3, index: 1}
        {val: -4, index: 0}
        {val: 2, index: 3}
      ]
    }
  }
}
