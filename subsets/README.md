# Subsets

## Problem
Given an integer array `nums` of **distinct** integers, return all possible subsets (the power set).

The solution set **must not** contain duplicate subsets. Return the solution in **any order**.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/subsets.xs`):** Contains the solution logic using iterative approach

## Function Signature
- **Input:** `nums: int[]` - An array of distinct integers
- **Output:** `int[][]` - Array of all possible subsets (including empty subset and full set)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 3]` | `[[], [1], [2], [1,2], [3], [1,3], [2,3], [1,2,3]]` |
| `[0]` | `[[], [0]]` |
| `[]` | `[[]]` |
| `[1, 2]` | `[[], [1], [2], [1,2]]` |

### Explanation
- For `[1, 2, 3]`, there are 2³ = 8 possible subsets (including empty and full set)
- For `[0]`, there are 2¹ = 2 subsets: empty and the element itself
- For empty input `[]`, the only subset is the empty subset `[[]]`

## Algorithm
The solution uses an **iterative approach**:
1. Start with the empty subset `[[]]`
2. For each number in the input array:
   - Take all existing subsets
   - Create new subsets by adding the current number to each existing subset
   - Add these new subsets to the result
3. Return the complete set of subsets

Time Complexity: O(n × 2ⁿ) where n is the length of nums
Space Complexity: O(n × 2ⁿ) for storing all subsets
