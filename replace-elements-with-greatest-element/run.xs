// Run job to test the replace_elements function
run.job "Test Replace Elements with Greatest Element" {
  main = {
    name: "replace_elements"
    input: {
      arr: [17, 18, 5, 4, 6, 1]
    }
  }
}
