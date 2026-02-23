run.job "Compare Version Numbers" {
  main = {
    name: "compare_versions"
    input: {
      version1: "1.2.3"
      version2: "1.2.4"
    }
  }
}
