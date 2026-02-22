# Min Stack

## Problem
Design a stack that supports push, pop, top, and retrieving the minimum element in constant time (O(1)).

Implement the `MinStack` class with the following methods:
- `push(val)`: Pushes the element `val` onto the stack
- `pop()`: Removes the element on the top of the stack
- `top()`: Gets the top element without removing it
- `getMin()`: Retrieves the minimum element in the stack

All operations must run in **O(1)** time complexity.

## Structure
- **Run Job (`run.xs`):** Calls the min_stack function with test inputs
- **Function (`function/min_stack.xs`):** Contains the Min Stack implementation using two stacks

## Function Signature
- **Input:**
  - `operations` (text[]): Array of operation names ("push", "pop", "top", "getMin")
  - `values` (int[]?): Array of values for push operations (null for other operations)
- **Output:** 
  - Returns an array of results. `null` for push/pop operations, actual values for top/getMin operations

## Test Cases

| Operations | Values | Expected Output |
|------------|--------|-----------------|
| `["push", "push", "push", "getMin", "pop", "top", "getMin"]` | `[-2, 0, -3, null, null, null, null]` | `[null, null, null, -3, null, 0, -2]` |
| `["push", "getMin", "push", "getMin"]` | `[5, null, 3, null]` | `[null, 5, null, 3]` |
| `["push", "push", "pop", "getMin"]` | `[2, 1, null, null]` | `[null, null, null, 2]` |
| `["getMin"]` | `[null]` | `[null]` |
| `["push", "push", "push", "pop", "getMin"]` | `[1, 1, 1, null, null]` | `[null, null, null, null, 1]` |

### Explanation of Test Case 1:
1. `push(-2)` → Stack: [-2], MinStack: [-2]
2. `push(0)` → Stack: [-2, 0], MinStack: [-2] (0 > -2, so no push to min)
3. `push(-3)` → Stack: [-2, 0, -3], MinStack: [-2, -3] (-3 < -2, push to min)
4. `getMin()` → Returns -3 (top of MinStack)
5. `pop()` → Removes -3, Stack: [-2, 0], MinStack: [-2] (popped value == min)
6. `top()` → Returns 0 (top of Stack)
7. `getMin()` → Returns -2 (top of MinStack)

## Algorithm
The solution uses **two stacks**:
1. **Main stack**: Stores all pushed values
2. **Min stack**: Stores minimum values only

- On `push(val)`: Always push to main stack. Push to min stack if min stack is empty OR val <= current minimum
- On `pop()`: Pop from main stack. If popped value equals current min, pop from min stack too
- On `top()`: Return top of main stack
- On `getMin()`: Return top of min stack

This ensures O(1) time for all operations while using O(n) extra space for the min stack.
