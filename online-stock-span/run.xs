// Run job to test the online_stock_span function
run.job "Test Online Stock Span" {
  main = {
    name: "online_stock_span"
    input: {
      prices: [100, 80, 60, 70, 60, 75, 85]
    }
  }
}
