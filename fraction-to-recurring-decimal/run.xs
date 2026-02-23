// Run job to test the fraction_to_recurring_decimal function
run.job "Test Fraction to Recurring Decimal" {
  main = {
    name: "fraction_to_recurring_decimal"
    input: {
      numerator: 1
      denominator: 2
    }
  }
}
