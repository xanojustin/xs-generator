run.job "Vimeo List Videos" {
  main = {
    name: "fetch_vimeo_videos"
    input: {
      page: 1
      per_page: 10
      filter: ""
      sort: "date"
      direction: "desc"
    }
  }
  env = ["VIMEO_ACCESS_TOKEN"]
}
