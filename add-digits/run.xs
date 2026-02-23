// Run job to test the add_digits function
// Add Digits (Digital Root): Repeatedly add digits until single digit remains
run.job "Test Add Digits" {
  main = {
    name: "add_digits"
    input: {
      num: 38
    }
  }
}
