# Four Sum

## Problem
Given an array of integers `nums` and an integer `target`, find all unique quadruplets `[a, b, c, d]` such that:
- `a + b + c + d = target`
- The solution set must not contain duplicate quadruplets

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/four_sum.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `nums` (int[]): Array of integers to search
  - `target` (int): Target sum value
- **Output:**
  - Array of quadruplets (int[][]), where each quadruplet sums to target

## Algorithm
The solution uses a two-pointer approach after sorting:
1. Sort the input array
2. Use two nested loops to fix the first two elements
3. Use two pointers (left and right) to find pairs that complete the sum
4. Skip duplicates at each level to ensure unique quadruplets

Time Complexity: O(n³) - three nested loops with two-pointer scan
Space Complexity: O(1) excluding output (or O(n) for the sort)

## Test Cases

| Input | Target | Expected Output |
|-------|--------|-----------------|
| `[1, 0, -1, 0, -2, 2]` | `0` | `[[-2, -1, 1, 2], [-2, 0, 0, 2], [-1, 0, 0, 1]]` |
| `[2, 2, 2, 2, 2]` | `8` | `[[2, 2, 2, 2]]` |
| `[]` | `0` | `[]` |
| `[1, 2, 3]` | `6` | `[]` (need at least 4 elements) |
| `[-3, -2, -1, 0, 0, 1, 2, 3]` | `0` | `[[-3, -2, 2, 3], [-3, -1, 1, 3], [-3, 0, 0, 3], [-3, 0, 1, 2], [-2, -1, 0, 3], [-2, -1, 1, 2], [-2, 0, 0, 2], [-1, 0, 0, 1]]` |

### Test Case Explanations
1. **Basic case:** Mixed positive and negative numbers with multiple valid quadruplets
2. **Duplicates:** Array with all same values should return only one unique quadruplet
3. **Empty input:** Empty array returns empty result
4. **Insufficient elements:** Less than 4 elements cannot form a quadruplet
5. **Multiple duplicates:** Complex case with many duplicate values and multiple solutions
