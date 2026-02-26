run.job "Destination City Finder" {
  main = {
    name: "find_destination_city"
    input: {
      paths: [["London", "New York"], ["New York", "Lima"], ["Lima", "Sao Paulo"]]
    }
  }
}
