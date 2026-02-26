// Run job to test the count_even_digit_numbers function
run.job "Test Count Even Digit Numbers" {
  main = {
    name: "count_even_digit_numbers"
    input: {
      nums: [12, 345, 2, 6, 7896]
    }
  }
}
