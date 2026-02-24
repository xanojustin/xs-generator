# Implement Stack Using Queues

## Problem
Implement a last-in-first-out (LIFO) stack using only two first-in-first-out (FIFO) queues. The implemented stack should support the following operations:

- `push(x)`: Push element x onto stack
- `pop()`: Remove and return the element on top of the stack
- `peek()`: Return the element on top of the stack without removing it
- `is_empty()`: Return whether the stack is empty

This is a classic data structure interview problem that tests understanding of stack vs queue semantics and requires creative use of queue operations to achieve LIFO behavior.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with a batch of test operations
- **Function (`function/stack_using_queues.xs`):** Contains the stack implementation using two queues

## Function Signature
- **Input:** 
  - `operation` (text): The operation to perform - "push", "pop", "peek", "is_empty", or "batch"
  - `payload` (json): The value to push (for push operation) or array of operations (for batch)
- **Output:** 
  - For single operations: Object with `success` boolean and relevant data (value, is_empty, error message)
  - For batch: Object with `success` boolean and `operations` array containing results for each operation

## Algorithm Explanation

The key insight is that a stack is LIFO (last in, first out) while a queue is FIFO (first in, first out). To implement a stack using queues:

**Push - O(1):**
- Simply enqueue to the main queue

**Pop - O(n):**
- Dequeue all elements from main queue except the last one, enqueue them to aux queue
- The last element in main queue is the top of stack - dequeue and return it
- Swap queues so aux becomes the new main queue

**Peek - O(1):**
- Simply return the last element of the main queue (top of stack)

**Is Empty - O(1):**
- Check if main queue is empty

## Test Cases

The run job executes the following batch of operations:

| Operation | Payload | Expected Result |
|-----------|---------|-----------------|
| is_empty | - | Stack is empty |
| push | 10 | Success |
| push | 20 | Success |
| push | 30 | Success |
| peek | - | Returns 30 (top of stack) |
| pop | - | Returns 30 |
| pop | - | Returns 20 |
| is_empty | - | Stack is NOT empty |
| pop | - | Returns 10 |
| pop | - | Error - Stack is empty |

### Additional Test Cases

| Input | Expected Output |
|-------|-----------------|
| `{"operation":"push","payload":5}` | `{"success":true,"message":"Pushed 5"}` |
| `{"operation":"pop"}` (after pushes of 1,2,3) | `{"success":true,"value":3}` |
| `{"operation":"peek"}` (after push of 42) | `{"success":true,"value":42}` |
| `{"operation":"is_empty"}` (empty stack) | `{"success":true,"is_empty":true}` |
| `{"operation":"pop"}` (empty stack) | `{"success":false,"error":"Stack is empty"}` |

## Complexity Analysis

| Operation | Time Complexity | Space Complexity |
|-----------|----------------|------------------|
| Push | O(1) | O(1) |
| Pop | O(n) | O(n) |
| Peek | O(1) | O(1) |
| Is Empty | O(1) | O(1) |

Where n is the number of elements in the stack.

## Notes
- This implementation uses the "lazy" approach where push is cheap and pop is expensive
- An alternative implementation could make pop O(1) and push O(n) by rotating the queue on every push
- The batch operation allows testing multiple operations in sequence while maintaining state
