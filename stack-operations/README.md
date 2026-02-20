# Stack Operations

## Problem
Implement a stack data structure (LIFO - Last In, First Out) with three core operations:
- **push**: Add an element to the top of the stack
- **pop**: Remove and return the top element from the stack
- **peek**: View the top element without removing it

The stack should handle edge cases like empty stacks and invalid operations gracefully.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/stack_operations.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `stack` (text[]): Initial stack array (bottom to top order)
  - `operation` (text): Operation to perform - "push", "pop", or "peek"
  - `value` (text): Value to push (only used for push operation)
- **Output:**
  - `success` (bool): Whether the operation succeeded
  - `result` (object): Operation result containing:
    - For push: `stack`, `top`, `size`, `operation`
    - For pop: `stack`, `popped`, `size`, `operation`
    - For peek: `stack`, `top`, `size`, `operation`
  - `error` (text): Error message if operation failed

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `stack: ["apple", "banana"], operation: "push", value: "cherry"` | `{success: true, result: {stack: ["apple", "banana", "cherry"], top: "cherry", size: 3, operation: "push"}}` |
| `stack: ["a", "b", "c"], operation: "pop"` | `{success: true, result: {stack: ["a", "b"], popped: "c", size: 2, operation: "pop"}}` |
| `stack: ["x", "y"], operation: "peek"` | `{success: true, result: {stack: ["x", "y"], top: "y", size: 2, operation: "peek"}}` |
| `stack: [], operation: "pop"` | `{success: false, error: "Cannot pop from empty stack"}` |
| `stack: [], operation: "peek"` | `{success: false, error: "Cannot peek empty stack"}` |
| `stack: ["a"], operation: "push", value: null` | `{success: false, error: "Value is required for push operation"}` |
| `stack: [], operation: "invalid"` | `{success: false, error: "Invalid operation: invalid. Use 'push', 'pop', or 'peek'."}` |

### Edge Cases Covered
- **Empty stack pop/peek:** Returns appropriate error messages
- **Missing value for push:** Validates that value is provided for push operation
- **Invalid operation:** Returns error for unrecognized operations
- **Single element stack:** Correctly handles stacks with one element
