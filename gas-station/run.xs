// Run job to test the gas_station function
// Gas Station: Find starting station to complete circular circuit
run.job "Test Gas Station" {
  main = {
    name: "gas_station"
    input: {
      gas: [1, 2, 3, 4, 5]
      cost: [3, 4, 5, 1, 2]
    }
  }
}
