// Run job to test the Design Underground System function
run.job "Test Underground System" {
  main = {
    name: "underground-system"
    input: {
      operation: "checkIn"
      customer_id: 45
      station_name: "Leyton"
      time: 3
    }
  }
}