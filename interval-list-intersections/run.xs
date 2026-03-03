run.job "interval_list_intersections_run" {
  main = {
    name: "interval_list_intersections"
    input: {
      first_list: {
        intervals: [[0,2],[5,10],[13,23],[24,25]]
      }
      second_list: {
        intervals: [[1,5],[8,12],[15,24],[25,26]]
      }
    }
  }
}
