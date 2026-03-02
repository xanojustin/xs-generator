# Max Stack

## Problem

Design a stack that supports the following operations in **O(1) time complexity**:

- `push(x)` — Push element x onto the stack
- `pop()` — Remove the element on the top of the stack
- `top()` — Get the top element without removing it
- `getMax()` — Retrieve the maximum element in the stack

The challenge is to implement `getMax()` in constant time while maintaining the standard stack operations. This requires using an auxiliary stack to track the maximum values.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/max_stack.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `operations` (text[]): Array of operation names to perform: `"push"`, `"pop"`, `"top"`, `"getMax"`
  - `values` (int[]): Array of values for push operations; null for operations that don't require values
  
- **Output:**
  - Returns an array of results. For `top` and `getMax` operations, the result is the value returned. For `push` and `pop` operations, the result is `null`.

## Algorithm Explanation

The solution uses two stacks:
1. **Main Stack**: Stores all pushed values
2. **Max Stack**: Stores only values that are greater than or equal to the current maximum

When pushing a value:
- Always push to the main stack
- Push to the max stack only if it's empty or the value is ≥ current max

When popping:
- Pop from the main stack
- If the popped value equals the top of the max stack, also pop from the max stack

This ensures the top of the max stack always contains the current maximum.

## Test Cases

| Operations | Values | Expected Output |
|------------|--------|-----------------|
| `["push", "push", "push", "getMax", "pop", "top", "getMax"]` | `[5, 1, 3, null, null, null, null]` | `[null, null, null, 5, null, 1, 1]` |
| `["push", "push", "getMax", "pop", "getMax"]` | `[1, 2, null, null, null]` | `[null, null, 2, null, 1]` |
| `["getMax", "pop", "top"]` | `[null, null, null]` | `[null, null, null]` |
| `["push", "getMax", "push", "getMax", "push", "getMax"]` | `[0, null, -1, null, 2, null]` | `[null, 0, null, 0, null, 2]` |

### Test Case Explanations

1. **Basic Operations**: Push 5, 1, 3. Max is 5. Pop (removes 3). Top is 1. Max is now 1.
2. **Increasing Values**: Push 1, then 2. Max is 2. Pop (removes 2). Max is now 1.
3. **Empty Stack**: Operations on an empty stack should return null.
4. **Negative and Mixed Values**: Tests with 0, -1, and 2 to ensure proper max tracking with mixed values.

## Complexity Analysis

- **Time Complexity**: O(n) for n operations (each operation is O(1))
- **Space Complexity**: O(n) in the worst case when all values are in decreasing order

## Related Problems

- **Min Stack**: Similar problem but tracking minimum values instead of maximum
- **Max Queue**: Similar concept applied to a queue data structure
