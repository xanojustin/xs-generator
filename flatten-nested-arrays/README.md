# Flatten Nested Arrays

## Problem

Given an array that may contain nested arrays at any depth, flatten it into a single-level array containing all elements in the same order (depth-first traversal).

For example:
- Input: `[1, [2, 3], [4, [5, 6]], 7]`
- Output: `[1, 2, 3, 4, 5, 6, 7]`

This exercise tests your ability to:
- Handle arbitrarily nested data structures
- Use iteration with a stack/queue pattern
- Process arrays of mixed types

## Function Signature

- **Input:** `nested_array` (json) - An array that may contain integers and/or nested arrays at any depth
- **Output:** `json` - A flat array containing all integer elements from the input, in depth-first order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 3]` | `[1, 2, 3]` |
| `[1, [2, 3], 4]` | `[1, 2, 3, 4]` |
| `[[1, 2], [3, 4]]` | `[1, 2, 3, 4]` |
| `[1, [2, [3, [4, 5]]]]` | `[1, 2, 3, 4, 5]` |
| `[]` | `[]` |
| `[1, [], 2]` | `[1, 2]` |
| `[1, [2, [3, [4, [5]]]]]` | `[1, 2, 3, 4, 5]` |

### Edge Cases Explained

1. **Already flat array `[1, 2, 3]`**: Should return the same array unchanged
2. **Empty array `[]`**: Should return empty array
3. **Empty nested arrays `[1, [], 2]`**: Should skip empty arrays and return `[1, 2]`
4. **Deeply nested `[1, [2, [3, [4, [5]]]]]`**: Tests handling of arbitrary nesting depth
5. **Multiple nesting at same level `[[1, 2], [3, 4]]`**: Tests correct handling of adjacent nested arrays
