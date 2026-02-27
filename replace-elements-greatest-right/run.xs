// Run job to test the replace_elements_greatest function
run.job "Test Replace Elements with Greatest Element on Right Side" {
  main = {
    name: "replace_greatest"
    input: {
      arr: [17, 18, 5, 4, 6, 1]
    }
  }
}
