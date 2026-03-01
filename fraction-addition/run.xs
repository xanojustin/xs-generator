// Run job to test the fraction addition function
run.job "Test Fraction Addition" {
  main = {
    name: "fraction_addition"
    input: {
      expression: "-1/2+1/2+1/3"
    }
  }
}
