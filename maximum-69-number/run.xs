// Run job to test the maximum_69_number function
// Maximum 69 Number: Change at most one digit (6->9) to get maximum number
run.job "Test Maximum 69 Number" {
  main = {
    name: "maximum_69_number"
    input: {
      num: 9669
    }
  }
}
