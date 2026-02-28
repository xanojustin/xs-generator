run.job "Logger Rate Limiter Test" {
  main = {
    name: "should_print_message"
    input: {
      message: "hello"
      timestamp: 1
      message_history: {}
    }
  }
}
