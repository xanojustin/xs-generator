# Merge K Sorted Lists

## Problem

Given an array of `k` sorted linked lists, merge them into one sorted linked list and return it.

In this implementation, linked lists are represented as arrays of integers, where each array is already sorted in ascending order.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/merge_k_sorted_lists.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `lists` (int[][]): An array of k sorted integer arrays (each inner array represents a sorted linked list)
  
- **Output:**
  - Returns int[]: A single sorted array containing all elements from all input lists

## Algorithm

The solution uses a selection sort approach:
1. Flatten all k lists into a single array of objects tracking value and processed status
2. Repeatedly find the minimum unprocessed value
3. Add it to the result and mark as processed
4. Continue until all elements are processed

Time Complexity: O(N²) where N is the total number of elements across all lists
Space Complexity: O(N) for storing the flattened list

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[1, 4, 5], [1, 3, 4], [2, 6]]` | `[1, 1, 2, 3, 4, 4, 5, 6]` |
| `[]` | `[]` |
| `[[], [], []]` | `[]` |
| `[[1]]` | `[1]` |
| `[[1, 2, 3], [4, 5, 6]]` | `[1, 2, 3, 4, 5, 6]` |
| `[[5], [1, 3], [2, 4, 6]]` | `[1, 2, 3, 4, 5, 6]` |

### Test Case Descriptions

1. **Standard case:** Three lists with overlapping ranges
2. **Empty array:** No lists to merge
3. **All empty lists:** k lists but all are empty
4. **Single element:** Just one list with one element
5. **Non-overlapping:** Lists with distinct ranges
6. **Uneven sizes:** Lists of different lengths
