// Run job to test the leap year function
run.job "Test Leap Year" {
  main = {
    name: "is_leap_year"
    input: {
      year: 2024
    }
  }
}
