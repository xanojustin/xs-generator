# Binary Search

## Problem

Implement the binary search algorithm to find a target value in a sorted array.

Given a sorted array of integers in ascending order and a target value, return the index of the target if found, or -1 if the target is not in the array.

Binary search works by repeatedly dividing the search interval in half:
1. Compare the target to the middle element of the array
2. If the target equals the middle element, return its index
3. If the target is less than the middle element, search the left half
4. If the target is greater than the middle element, search the right half
5. Repeat until the target is found or the search space is exhausted

This algorithm has O(log n) time complexity, making it much more efficient than linear search for large datasets.

## Function Signature

- **Input:** 
  - `nums` (int[]) - A sorted array of integers in ascending order
  - `target` (int) - The value to search for
- **Output:** `int` - The index of the target value if found, -1 otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums: [1, 2, 3, 4, 5], target: 3` | `2` |
| `nums: [1, 2, 3, 4, 5], target: 1` | `0` |
| `nums: [1, 2, 3, 4, 5], target: 5` | `4` |
| `nums: [1, 2, 3, 4, 5], target: 6` | `-1` |
| `nums: [], target: 1` | `-1` |
| `nums: [42], target: 42` | `0` |
| `nums: [42], target: 99` | `-1` |
| `nums: [-10, -5, 0, 5, 10], target: -5` | `1` |
| `nums: [1, 3, 5, 7, 9, 11, 13, 15, 17, 19], target: 15` | `7` |

### Edge Cases Explained

1. **Empty array**: Should return -1 immediately since there's nothing to search
2. **Single element (found)**: Tests the simplest case where the target is the only element
3. **Single element (not found)**: Tests when array has one element but it's not the target
4. **Target at boundaries**: Tests first and last elements (indices 0 and n-1)
5. **Target not in array**: Should return -1 after exhausting search space
6. **Negative numbers**: Verifies algorithm works with negative integers
7. **Large array**: Tests efficiency with a longer sorted array
