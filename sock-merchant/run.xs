run.job "Sock Merchant" {
  main = {
    name: "sock_merchant"
    input: {
      socks: [1, 2, 1, 2, 1, 3, 2]
    }
  }
}
