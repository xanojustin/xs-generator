// Run job to test the My Calendar I function
run.job "Test My Calendar I" {
  main = {
    name: "my_calendar"
    input: {
      bookings: [
        { start: 10, end: 20 },
        { start: 15, end: 25 },
        { start: 20, end: 30 }
      ]
    }
  }
}
