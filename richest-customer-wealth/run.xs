run.job "Richest Customer Wealth" {
  main = {
    name: "richest_customer_wealth"
    input: {
      accounts: [[1, 2, 3], [3, 2, 1]]
    }
  }
}
