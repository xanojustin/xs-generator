# Find Duplicates

## Problem

Given an array of integers, find all elements that appear more than once (duplicates).

Return an array containing each duplicate value only once, in the order they were first identified as duplicates.

This is a classic array problem that tests hash set / tracking patterns and efficient duplicate detection.

## Function Signature

- **Input:** `numbers` (int[]) - An array of integers to check for duplicates
- **Output:** `int[]` - An array of unique duplicate values (each duplicate appears only once in the result)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 3, 2, 4, 3, 5]` | `[2, 3]` |
| `[1, 1, 1, 1]` | `[1]` |
| `[1, 2, 3, 4, 5]` | `[]` |
| `[]` | `[]` |
| `[42]` | `[]` |
| `[-1, -2, -1, 3, -2]` | `[-1, -2]` |
| `[5, 4, 3, 2, 1, 2, 3, 4, 5]` | `[2, 3, 4, 5]` |

### Edge Cases Explained

1. **Empty array `[]`**: No elements means no duplicates - returns empty array
2. **Single element `[42]`**: One element cannot be a duplicate - returns empty array
3. **All same elements `[1, 1, 1, 1]`**: Returns `[1]` (each duplicate only once in result)
4. **No duplicates `[1, 2, 3, 4, 5]`**: Returns empty array
5. **Negative numbers `[-1, -2, -1, 3, -2]`**: Duplicates work with negative integers too
6. **Multiple duplicates appearing multiple times**: Each duplicate value appears only once in the result, regardless of how many times it appears in the input
