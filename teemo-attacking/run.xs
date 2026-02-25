// Run job to test the teemo_attacking function
run.job "Test Teemo Attacking" {
  main = {
    name: "teemo_attacking"
    input: {
      time_series: [1, 4]
      duration: 2
    }
  }
}
