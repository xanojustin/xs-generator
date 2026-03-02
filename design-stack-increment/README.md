# Design a Stack With Increment Operation

## Problem
Design a stack that supports the following operations:
- **push(x)**: Pushes element x onto the stack
- **pop()**: Removes and returns the top element of the stack. Returns -1 if the stack is empty
- **increment(k, val)**: Increments the bottom k elements of the stack by val

This is LeetCode problem #1381.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test operations
- **Function (`function/design_stack_increment.xs`):** Contains the stack implementation logic

## Function Signature
- **Input:** 
  - `operations`: Array of operation names ("push", "pop", "increment")
  - `values`: Array of parameter arrays for each operation
- **Output:** Array of results (null for push/increment, popped value for pop)

## Test Cases

| Operations | Values | Expected Output |
|------------|--------|-----------------|
| `["push","push","pop"]` | `[[1],[2],[]]` | `[null,null,2]` |
| `["push","push","increment","pop"]` | `[[1],[2],[2,10],[]]` | `[null,null,null,11]` |
| `["pop"]` | `[[]]` | `[-1]` |
| `["push","push","push","increment","increment","pop","pop"]` | `[[1],[2],[3],[2,100],[3,200],[],[]]` | `[null,null,null,null,null,203,102]` |

### Test Case Explanations:

1. **Basic push/pop**: Push 1, push 2, pop returns 2
2. **Increment then pop**: Push 1, push 2, increment bottom 2 by 10 (stack becomes [11, 12]), pop returns 12
3. **Pop from empty**: Returns -1
4. **Complex sequence**: 
   - Push 1, 2, 3 → stack: [1, 2, 3]
   - Increment bottom 2 by 100 → stack: [101, 102, 3]
   - Increment bottom 3 by 200 → stack: [301, 302, 203]
   - Pop returns 203, pop returns 302
