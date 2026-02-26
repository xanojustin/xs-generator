run.job "Defang IP Address Test" {
  main = {
    name: "defang_ip"
    input: {
      address: "1.1.1.1"
    }
  }
}
