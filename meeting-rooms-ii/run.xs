run.job "Meeting Rooms II Test" {
  main = {
    name: "meeting_rooms_ii"
    input: {
      intervals: [[0, 30], [5, 10], [15, 20]]
    }
  }
}
