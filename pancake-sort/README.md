# Pancake Sort

## Problem
Implement the pancake sort algorithm to sort an array of integers in ascending order.

Pancake sorting is a sorting algorithm that sorts an array by repeatedly flipping (reversing) prefixes of the array. The only allowed operation is to flip a prefix of the array (like flipping a stack of pancakes with a spatula).

### Algorithm
1. Find the index of the maximum element in the unsorted portion of the array
2. Flip the array from index 0 to max_index to bring the maximum element to the front
3. Flip the array from index 0 to the end of the unsorted portion to move the maximum to its correct position
4. Reduce the unsorted portion by 1 and repeat until the array is sorted

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/pancake_sort.xs`):** Contains the pancake sort implementation

## Function Signature
- **Input:** 
  - `arr` (int[]): Array of integers to sort
- **Output:** 
  - Returns the sorted array (int[])

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[23, 10, 20, 11, 12, 6, 7]` | `[6, 7, 10, 11, 12, 20, 23]` |
| `[3, 2, 4, 1]` | `[1, 2, 3, 4]` |
| `[]` | `[]` |
| `[5]` | `[5]` |
| `[1, 2, 3, 4]` | `[1, 2, 3, 4]` (already sorted) |
| `[4, 3, 2, 1]` | `[1, 2, 3, 4]` (reverse sorted) |
| `[-5, -10, 0, 5, 3]` | `[-10, -5, 0, 3, 5]` (with negative numbers) |

### Test Case Explanations
1. **Basic case:** Standard unsorted array
2. **Small array:** Minimal non-trivial case
3. **Empty array:** Edge case - should handle gracefully
4. **Single element:** Edge case - already sorted
5. **Already sorted:** Should not break with sorted input
6. **Reverse sorted:** Worst case for pancake sort
7. **With negatives:** Tests handling of negative integers
