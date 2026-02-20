# Queue Operations

## Problem
Implement a **Queue** data structure using XanoScript. A queue follows the First-In-First-Out (FIFO) principle: the first element added is the first one to be removed.

The queue should support the following operations:
- **enqueue**: Add an item to the back of the queue
- **dequeue**: Remove and return the front item from the queue
- **peek**: Return the front item without removing it
- **isEmpty**: Check if the queue is empty (returns boolean)
- **size**: Return the number of items in the queue

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/queue_operations.xs`):** Contains the queue implementation

## Function Signature
- **Input:**
  - `operation` (text): The operation to perform - one of "enqueue", "dequeue", "peek", "isEmpty", or "size"
  - `queue` (json): The current queue state as an array (index 0 represents the front)
  - `item` (json, optional): The item to add when using the "enqueue" operation

- **Output:**
  - `success` (bool): Whether the operation succeeded
  - `result` (json): The result of the operation (varies by operation type)
  - `error` (text): Error message if the operation failed
  - `queue` (json): The updated queue state after the operation

## Operation Details

| Operation | Input Required | Result on Success | Error Cases |
|-----------|---------------|-------------------|-------------|
| `enqueue` | `item` | Updated queue array | Missing item parameter |
| `dequeue` | None | Object with `item` and `queue` | Empty queue |
| `peek` | None | Front item value | Empty queue |
| `isEmpty` | None | Boolean | None |
| `size` | None | Integer count | None |

## Test Cases

| Operation | Input Queue | Item | Expected Result | Expected Queue After |
|-----------|-------------|------|-----------------|---------------------|
| `enqueue` | `[]` | `10` | `[10]` | `[10]` |
| `enqueue` | `[10]` | `20` | `[10, 20]` | `[10, 20]` |
| `dequeue` | `[10, 20, 30]` | - | `{ item: 10, queue: [20, 30] }` | `[20, 30]` |
| `peek` | `[10, 20]` | - | `10` | `[10, 20]` (unchanged) |
| `isEmpty` | `[]` | - | `true` | `[]` (unchanged) |
| `isEmpty` | `[10]` | - | `false` | `[10]` (unchanged) |
| `size` | `[10, 20, 30]` | - | `3` | `[10, 20, 30]` (unchanged) |
| `dequeue` | `[]` | - | Error: "Cannot dequeue from empty queue" | `[]` |
| `peek` | `[]` | - | Error: "Cannot peek empty queue" | `[]` |

## Example Usage Flow

1. Start with empty queue: `[]`
2. `enqueue(10)` → Queue: `[10]`
3. `enqueue(20)` → Queue: `[10, 20]`
4. `enqueue(30)` → Queue: `[10, 20, 30]`
5. `peek()` → Returns `10`, Queue: `[10, 20, 30]`
6. `dequeue()` → Returns `10`, Queue: `[20, 30]`
7. `size()` → Returns `2`, Queue: `[20, 30]`
8. `isEmpty()` → Returns `false`, Queue: `[20, 30]`
9. `dequeue()` → Returns `20`, Queue: `[30]`
10. `dequeue()` → Returns `30`, Queue: `[]`
11. `isEmpty()` → Returns `true`, Queue: `[]`
