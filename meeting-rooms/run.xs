// Run job to test the meeting rooms function
run.job "Test Meeting Rooms" {
  main = {
    name: "can_attend_all_meetings"
    input: {
      intervals: [
        { start: 0, end: 30 },
        { start: 5, end: 10 },
        { start: 15, end: 20 }
      ]
    }
  }
}
