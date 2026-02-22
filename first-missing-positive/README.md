# First Missing Positive

## Problem

Given an unsorted integer array `nums`, return the **smallest positive integer** that is not present in the array.

The algorithm must run in O(n) time and use O(1) auxiliary space (modifying the input array is allowed).

### Key Insight
For an array of size `n`, the answer must be in the range `[1, n+1]`. This is because:
- If all numbers from 1 to n are present, the answer is n+1
- Otherwise, the answer is the smallest missing positive in [1, n]

### Approach
We use the array itself as a hash map by placing each number in its "correct" position:
- Number `x` should be at index `x-1` (i.e., 1 at index 0, 2 at index 1, etc.)
- After rearrangement, the first position where the number doesn't equal `index + 1` reveals the missing positive

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input `[3, 4, -1, 1]`
- **Function (`function/first_missing_positive.xs`):** Contains the solution logic using cyclic sort pattern

## Function Signature

- **Input:**
  - `nums` (`int[]`): An unsorted array of integers (may contain negative numbers, zeros, and duplicates)

- **Output:** 
  - `int`: The smallest positive integer (≥ 1) that does not appear in the array

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 0]` | `3` | 1 and 2 are present, so next positive is 3 |
| `[3, 4, -1, 1]` | `2` | 1 is present, 2 is missing |
| `[-1, -2, -3]` | `1` | No positive numbers, so 1 is missing |
| `[7, 8, 9, 11, 12]` | `1` | 1 is not in the array |
| `[1]` | `2` | Only 1 is present |
| `[]` | `1` | Empty array, 1 is missing |
| `[1, 2, 3, 4, 5]` | `6` | All 1-5 present, next is 6 |
| `[2, 2, 2, 2]` | `1` | 1 is not in the array |

### Edge Cases
- **Empty array:** Returns 1
- **All negatives:** Returns 1
- **All numbers > n:** Returns 1
- **Complete sequence [1..n]:** Returns n+1
- **Duplicates:** Handled correctly, doesn't cause infinite loops

## Complexity Analysis

- **Time Complexity:** O(n) - Each element is swapped at most once into its correct position
- **Space Complexity:** O(1) - In-place rearrangement, only using a few variables
