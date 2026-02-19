# Stack Operations

## Problem

Implement a **stack** (Last-In-First-Out / LIFO) data structure with the following operations:

- **push**: Add an element to the top of the stack
- **pop**: Remove and return the top element from the stack
- **peek**: Return the top element without removing it
- **isempty**: Check if the stack is empty (returns true/false)
- **size**: Return the number of elements in the stack

A stack follows the LIFO principle: the last element added is the first one to be removed. Think of it like a stack of plates - you can only add or remove plates from the top.

## Function Signature

- **Input:**
  - `initial_stack` (text[]?, default: []) - Optional initial elements to populate the stack
  - `operation` (text, required) - The operation to perform: `"push"`, `"pop"`, `"peek"`, `"isempty"`, `"size"`, or `"getall"`
  - `value` (text?, optional) - The value to push (required only for push operation)

- **Output:** (object)
  - `success` (bool) - Whether the operation succeeded
  - `operation` (text) - The operation that was performed
  - Various fields depending on operation (see test cases below)

## Test Cases

### Basic Operations

| Input | Expected Output |
|-------|-----------------|
| `operation: "push"`, `value: "apple"` | `{success: true, operation: "push", value: "apple", stack: ["apple"], size: 1}` |
| `operation: "pop"`, `initial_stack: ["a", "b", "c"]` | `{success: true, operation: "pop", popped: "c", stack: ["a", "b"], size: 2}` |
| `operation: "peek"`, `initial_stack: ["x", "y", "z"]` | `{success: true, operation: "peek", top: "z", stack: ["x", "y", "z"], size: 3}` |
| `operation: "isempty"`, `initial_stack: []` | `{success: true, operation: "isempty", isempty: true, size: 0}` |
| `operation: "size"`, `initial_stack: ["one", "two", "three"]` | `{success: true, operation: "size", size: 3}` |

### Edge Cases

| Input | Expected Output |
|-------|-----------------|
| `operation: "pop"`, `initial_stack: []` | Error: "Cannot pop from an empty stack" |
| `operation: "peek"`, `initial_stack: []` | Error: "Cannot peek into an empty stack" |
| `operation: "push"` (no value) | Error: "Value is required for push operation" |
| `operation: "isempty"`, `initial_stack: ["item"]` | `{isempty: false, size: 1}` |
| `operation: "pop"`, `initial_stack: ["single"]` | `popped: "single", stack: [], size: 0` |

### LIFO Verification

| Sequence | Expected State |
|----------|----------------|
| Push: A, B, C → Pop → Pop | After pops: top would be "A" if peeked, stack: ["A"] |
| Push: 1 → Pop → Push: 2 → Peek | `peek` returns "2", stack: ["2"] |

### Complex Scenarios

| Description | Sequence | Expected Result |
|-------------|----------|-----------------|
| Multiple pushes | Push X, Y, Z → Getall | Stack: ["X", "Y", "Z"] (preserves order, Z is top) |
| Interleaved operations | Push A, Push B, Pop, Push C, Getall | Stack: ["A", "C"] (B was popped) |
| Size tracking | Size → Push X → Size → Pop → Size | Returns: 0, 1, 0 |
| Stack underflow | Push A → Pop → Pop | Second pop should error (stack empty) |
