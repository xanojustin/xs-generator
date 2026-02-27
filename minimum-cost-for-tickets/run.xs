// Run job to test the minimum cost for tickets function
run.job "Test Minimum Cost For Tickets" {
  main = {
    name: "minimum_cost_for_tickets"
    input: {
      days: [1, 4, 6, 7, 8, 20]
      costs: [2, 7, 15]
    }
  }
}
