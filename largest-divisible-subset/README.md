# Largest Divisible Subset

## Problem
Given a set of distinct positive integers `nums`, return the largest subset `answer` such that every pair of elements in this subset satisfies one of the following conditions:
- `answer[i] % answer[j] == 0` (one element is divisible by the other)
- `answer[j] % answer[i] == 0`

In other words, for any two elements in the subset, one must be divisible by the other.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/largest_divisible_subset.xs`):** Contains the solution logic using dynamic programming

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of distinct positive integers
- **Output:** 
  - `subset` (int[]): The largest divisible subset (in ascending order)
  - `size` (int): The size of the subset

## Approach
1. **Sort the array** - Processing smaller numbers first ensures that when we consider a number, all its potential divisors have already been processed
2. **Dynamic Programming** - `dp[i]` stores the size of the largest divisible subset ending with `sorted[i]`
3. **Parent tracking** - `parent[i]` stores the index of the previous element in the subset to allow reconstruction
4. **Backtrack** - After finding the maximum subset size, backtrack through parent pointers to reconstruct the subset

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 3, 4, 8, 12]` | Subset: `[1, 2, 4, 8]` or `[1, 2, 4, 12]` (size 4) |
| `[1]` | Subset: `[1]` (size 1) |
| `[]` | Subset: `[]` (size 0) |
| `[2, 3, 5, 7, 11]` | Subset: `[2]` or `[3]` etc. (size 1 - no divisibility pairs) |
| `[2, 4, 8, 16, 32]` | Subset: `[2, 4, 8, 16, 32]` (size 5 - all powers of 2) |

## Example
```
Input: [1, 2, 3, 4, 8, 12]

After sorting: [1, 2, 3, 4, 8, 12]

DP table construction:
- dp[0] = 1 (subset: [1])
- dp[1] = 2 (subset: [1, 2]) because 2 % 1 == 0
- dp[2] = 2 (subset: [1, 3]) because 3 % 1 == 0
- dp[3] = 3 (subset: [1, 2, 4]) because 4 % 2 == 0 and 4 % 1 == 0
- dp[4] = 4 (subset: [1, 2, 4, 8]) because 8 % 4 == 0
- dp[5] = 4 (subset: [1, 2, 4, 12]) because 12 % 4 == 0

Output: { subset: [1, 2, 4, 8], size: 4 }
```
