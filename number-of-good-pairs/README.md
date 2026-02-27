# Number of Good Pairs

## Problem

Given an array of integers `nums`, return the number of **good pairs**.

A pair `(i, j)` is called good if:
- `nums[i] == nums[j]`
- `i < j`

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/number_of_good_pairs.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `nums` (int[]): Array of integers
- **Output:**
  - `count` (int): Number of good pairs in the array

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 3, 1, 1, 3]` | `4` |
| `[1, 1, 1, 1]` | `6` |
| `[1, 2, 3]` | `0` |
| `[]` | `0` |
| `[5]` | `0` |

### Test Case Descriptions

1. **Basic case `[1, 2, 3, 1, 1, 3]`:** Pairs are (0,3), (0,4), (3,4), and (2,5) = 4 pairs
2. **All same elements `[1, 1, 1, 1]`:** 6 pairs (n*(n-1)/2 where n=4)
3. **No pairs `[1, 2, 3]`:** All elements unique, no good pairs
4. **Empty array `[]`:** Edge case, returns 0
5. **Single element `[5]`:** Edge case, returns 0

## Algorithm

The solution uses a brute-force nested loop approach:
- Outer loop iterates through each element at index `i`
- Inner loop checks all elements at index `j` where `j > i`
- If `nums[i] == nums[j]`, increment the count

Time Complexity: O(n²)
Space Complexity: O(1)
