run.job "Design Circular Queue Test" {
  main = {
    name: "circular_queue"
    input: {
      capacity: 3
      operations: [
        { type: "isEmpty" },
        { type: "enqueue", value: 1 },
        { type: "enqueue", value: 2 },
        { type: "enqueue", value: 3 },
        { type: "isFull" },
        { type: "enqueue", value: 4 },
        { type: "front" },
        { type: "rear" },
        { type: "dequeue" },
        { type: "enqueue", value: 4 },
        { type: "front" },
        { type: "rear" },
        { type: "isEmpty" },
        { type: "dequeue" },
        { type: "dequeue" },
        { type: "dequeue" },
        { type: "isEmpty" },
        { type: "dequeue" }
      ]
    }
  }
}
