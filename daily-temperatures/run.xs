// Run job to test the daily_temperatures function
run.job "Test Daily Temperatures" {
  main = {
    name: "daily_temperatures"
    input: {
      temperatures: "[73, 74, 75, 71, 69, 72, 76, 73]"
    }
  }
}
