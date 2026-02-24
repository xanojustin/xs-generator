# Kids With Candies

## Problem
Given an array `candies` where `candies[i]` represents the number of candies the ith kid has, and an integer `extraCandies`, return a boolean array `result` of length `n`, where `result[i]` is `true` if, after giving the ith kid all the `extraCandies`, they will have the greatest number of candies among all the kids, or `false` otherwise.

Note: Multiple kids can have the greatest number of candies.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/kidsWithCandies.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `candies` (int[]): Array where each element represents candies a kid has
  - `extraCandies` (int): Number of extra candies to give to one kid
- **Output:**
  - bool[]: Array where each element indicates if that kid could have the greatest number of candies

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `candies: [2, 3, 5, 1, 3]`, `extraCandies: 3` | `[true, true, true, false, true]` |
| `candies: [4, 2, 1, 1, 2]`, `extraCandies: 1` | `[true, false, false, false, false]` |
| `candies: [1]`, `extraCandies: 0` | `[true]` |
| `candies: [1, 1, 1]`, `extraCandies: 0` | `[true, true, true]` |

### Explanation of Test Cases:
1. **Basic case:** Kid at index 2 already has 5 (max), so they stay greatest. Kids at indices 0, 1, and 4 can reach 5 or more with 3 extra candies.
2. **Single winner:** Only kid at index 0 can remain greatest with 1 extra candy (4+1=5, which is >= max of 4).
3. **Single kid edge case:** Only one kid, so they automatically have the greatest.
4. **All equal:** All kids already have equal candies, so all can be greatest.
