# Queue Operations

## Problem

Implement a queue (First-In-First-Out / FIFO) data structure with the following operations:

- **enqueue**: Add an element to the back of the queue
- **dequeue**: Remove and return the front element from the queue
- **peek**: Return the front element without removing it
- **isempty**: Check if the queue is empty (returns true/false)
- **size**: Return the number of elements in the queue

A queue follows the FIFO principle: the first element added is the first one to be removed. Think of it like a line of people waiting - the person who arrived first gets served first.

## Function Signature

- **Input:**
  - `initial_queue` (text[]?, default: []) - Optional initial elements to populate the queue
  - `operation` (text, required) - The operation to perform: `"enqueue"`, `"dequeue"`, `"peek"`, `"isempty"`, `"size"`, or `"getall"`
  - `value` (text?, optional) - The value to enqueue (required only for enqueue operation)

- **Output:** (object)
  - `success` (bool) - Whether the operation succeeded
  - `operation` (text) - The operation that was performed
  - Various fields depending on operation (see test cases below)

## Test Cases

### Basic Operations

| Input | Expected Output |
|-------|-----------------|
| `operation: "enqueue"`, `value: "apple"` | `{success: true, operation: "enqueue", value: "apple", queue: ["apple"], size: 1}` |
| `operation: "dequeue"`, `initial_queue: ["a", "b", "c"]` | `{success: true, operation: "dequeue", dequeued: "a", queue: ["b", "c"], size: 2}` |
| `operation: "peek"`, `initial_queue: ["x", "y", "z"]` | `{success: true, operation: "peek", front: "x", queue: ["x", "y", "z"], size: 3}` |
| `operation: "isempty"`, `initial_queue: []` | `{success: true, operation: "isempty", isempty: true, size: 0}` |
| `operation: "size"`, `initial_queue: ["one", "two", "three"]` | `{success: true, operation: "size", size: 3}` |

### Edge Cases

| Input | Expected Output |
|-------|-----------------|
| `operation: "dequeue"`, `initial_queue: []` | Error: "Cannot dequeue from an empty queue" |
| `operation: "peek"`, `initial_queue: []` | Error: "Cannot peek into an empty queue" |
| `operation: "enqueue"` (no value) | Error: "Value is required for enqueue operation" |
| `operation: "isempty"`, `initial_queue: ["item"]` | `{isempty: false, size: 1}` |
| `operation: "dequeue"`, `initial_queue: ["single"]` | `dequeued: "single", queue: [], size: 0` |

### FIFO Verification

| Sequence | Expected State |
|----------|----------------|
| Enqueue: A, B, C → Dequeue → Dequeue | After dequeues: front is "C", queue: ["C"] |
| Enqueue: 1 → Dequeue → Enqueue: 2 → Peek | `peek` returns "2", not "1" (1 was already removed) |

### Complex Scenarios

| Description | Sequence | Expected Result |
|-------------|----------|-----------------|
| Multiple enqueues | Enqueue X, Y, Z → Getall | Queue: ["X", "Y", "Z"] (preserves order) |
| Interleaved operations | Enqueue A, Enqueue B, Dequeue, Enqueue C, Getall | Queue: ["B", "C"] |
| Size tracking | Size → Enqueue X → Size → Dequeue → Size | Returns: 0, 1, 0 |
