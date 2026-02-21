# Queue Using Stacks

## Problem
Implement a First-In-First-Out (FIFO) queue using only two Last-In-First-Out (LIFO) stacks.

A queue supports the following standard operations:
- **Enqueue**: Add an element to the back of the queue
- **Dequeue**: Remove and return the element from the front of the queue
- **Peek**: Return the front element without removing it
- **Is Empty**: Check if the queue has no elements

The challenge is to implement these operations using only stack operations (push, pop, peek).

### Algorithm Explanation
- **stack_in**: Used for enqueue operations (push elements here)
- **stack_out**: Used for dequeue operations

**Enqueue**: Simply push to `stack_in` (O(1))

**Dequeue**:
1. If `stack_out` is empty, pop all elements from `stack_in` and push to `stack_out` (this reverses the order)
2. Pop from `stack_out` (O(1) amortized, O(n) worst case when transfer is needed)

This approach maintains FIFO order because elements are reversed when transferred from `stack_in` to `stack_out`, making the oldest element accessible at the top of `stack_out`.

## Structure
- **Run Job (`run.xs`):** Calls the test function to run all test cases
- **Function (`function/queue_using_stacks.xs`):** Contains the queue implementation using two stacks
- **Test Function (`function/queue_test.xs`):** Contains comprehensive test cases

## Function Signature
- **Input:**
  - `operation` (text): The operation to perform - "enqueue", "dequeue", "peek", "is_empty", or "batch"
  - `payload` (json): The payload for the operation:
    - For "enqueue": the value to enqueue
    - For "batch": an array of operation objects
    - For other operations: not used
- **Output:** (object)
  - `success` (bool): Whether the operation succeeded
  - For enqueue: `{ success: true, message: "Enqueued X" }`
  - For dequeue: `{ success: true, value: X }` or `{ success: false, error: "Queue is empty" }`
  - For peek: `{ success: true, value: X }` or `{ success: false, error: "Queue is empty" }`
  - For is_empty: `{ success: true, is_empty: true/false }`
  - For batch: `{ success: true, operations: [...results] }`

## Test Cases

| Test | Operations | Expected Behavior |
|------|-----------|-------------------|
| Basic enqueue/dequeue | Enqueue 1,2,3 then dequeue | Returns 1 (FIFO order) |
| FIFO verification | Enqueue a,b,c then dequeue all | Returns a,b,c in order |
| Peek | Enqueue 10,20 then peek | Returns 10 without removing |
| Is empty | Check empty, enqueue, check again | true → false |
| Empty dequeue | Dequeue from empty queue | Error: "Queue is empty" |
| Interleaved | Enqueue 1,2 → dequeue → enqueue 3 → dequeue all | Returns 1,2,3 |
| Single element | Enqueue "solo" → peek → dequeue → check empty | Peek: solo, Dequeue: solo, Empty: true |

## Complexity Analysis

| Operation | Time Complexity | Space Complexity |
|-----------|----------------|------------------|
| Enqueue | O(1) | O(n) |
| Dequeue | O(1) amortized, O(n) worst case | O(n) |
| Peek | O(1) amortized, O(n) worst case | O(n) |
| Is Empty | O(1) | O(1) |

Where n is the number of elements in the queue.

## Why This Problem Matters
This is a classic interview question that tests:
1. Understanding of fundamental data structures (stacks vs queues)
2. Ability to combine simple structures to create more complex ones
3. Amortized analysis understanding
4. Clean implementation of stateful operations
