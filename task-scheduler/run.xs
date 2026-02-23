run.job "Task Scheduler" {
  main = {
    name: "task_scheduler"
    input: {
      tasks: ["A", "A", "A", "B", "B", "B"],
      n: 2
    }
  }
}
