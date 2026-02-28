run.job "Design Browser History Test" {
  main = {
    name: "design_browser_history"
    input: {
      operation: "init"
      history: []
      current_index: 0
      url: "google.com"
    }
  }
}