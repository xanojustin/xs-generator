run.job "Boat Racing Handicap Calculator" {
  main = {
    name: "calculate_handicap"
    input: {
      phrf_rating: 120
      course_distance: 5.5
      elapsed_time_seconds: 7200
    }
  }
}