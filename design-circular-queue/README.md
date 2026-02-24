# Design Circular Queue

## Problem

Design your implementation of the circular queue. The circular queue is a linear data structure in which the operations are performed based on FIFO (First In First Out) principle and the last position is connected back to the first position to make a circle. It is also called "Ring Buffer".

Implement the following operations:
- `enqueue(value)`: Insert an element into the circular queue. Return true if the operation is successful.
- `dequeue()`: Delete an element from the circular queue. Return the value if successful.
- `front()`: Get the front item from the queue. If the queue is empty, return an error.
- `rear()`: Get the last item from the queue. If the queue is empty, return an error.
- `isEmpty()`: Checks whether the circular queue is empty or not.
- `isFull()`: Checks whether the circular queue is full or not.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs demonstrating all circular queue operations
- **Function (`function/circular_queue.xs`):** Contains the circular queue implementation with array-based storage and index tracking

## Function Signature

- **Input:**
  - `capacity` (int): Maximum capacity of the circular queue
  - `operations` (object[]): Array of operations to perform, where each operation has:
    - `type` (text): Operation type - "enqueue", "dequeue", "front", "rear", "isEmpty", or "isFull"
    - `value` (int?, optional): Value to enqueue (only for enqueue operation)

- **Output:**
  - `capacity` (int): Maximum capacity of the queue
  - `current_size` (int): Current number of elements in the queue
  - `front_index` (int): Index of the front pointer
  - `rear_index` (int): Index of the rear pointer
  - `operation_results` (object[]): Results of each operation performed

## Test Cases

The run job executes the following sequence of operations on a queue with capacity 3:

| Step | Operation | Input/Expected Result |
|------|-----------|----------------------|
| 1 | isEmpty | Returns `true` (queue is initially empty) |
| 2 | enqueue(1) | Success, queue: [1] |
| 3 | enqueue(2) | Success, queue: [1, 2] |
| 4 | enqueue(3) | Success, queue: [1, 2, 3] (full) |
| 5 | isFull | Returns `true` |
| 6 | enqueue(4) | Fails (queue full), returns error |
| 7 | front | Returns `1` (first element) |
| 8 | rear | Returns `3` (last element) |
| 9 | dequeue | Returns `1`, queue: [2, 3] |
| 10 | enqueue(4) | Success (wraps around), queue: [2, 3, 4] |
| 11 | front | Returns `2` |
| 12 | rear | Returns `4` |
| 13 | isEmpty | Returns `false` |
| 14 | dequeue | Returns `2`, queue: [3, 4] |
| 15 | dequeue | Returns `3`, queue: [4] |
| 16 | dequeue | Returns `4`, queue: [] |
| 17 | isEmpty | Returns `true` |
| 18 | dequeue | Fails (queue empty), returns error |

## Implementation Notes

The circular queue uses an array-based implementation with:
- `front` index: Points to the first element
- `rear` index: Points to the last element
- `size` counter: Tracks current number of elements

The circular nature is achieved using modulo arithmetic: `next_index = (current_index + 1) % capacity`

This allows the queue to wrap around when it reaches the end of the allocated space, making efficient use of the fixed-size buffer.
