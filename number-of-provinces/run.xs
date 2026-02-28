// Run job to test the countProvinces function
run.job "Test Number of Provinces" {
  main = {
    name: "countProvinces"
    input: {
      isConnected: [
        [1, 1, 0],
        [1, 1, 0],
        [0, 0, 1]
      ]
    }
  }
}
