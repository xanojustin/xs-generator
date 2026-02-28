// Run job to test the bank system
run.job "Test Bank System" {
  main = {
    name: "bank-system"
    input: {
      operation: "balance"
      account_id: 1
    }
  }
}
