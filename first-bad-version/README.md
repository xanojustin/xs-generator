# First Bad Version

## Problem
You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.

Suppose you have `n` versions `[1, 2, ..., n]` and you want to find out the first bad one, which causes all the following ones to be bad.

You are given an API `bool isBadVersion(version)` which returns whether `version` is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/firstBadVersion.xs`):** Contains the binary search solution logic

## Function Signature
- **Input:**
  - `n` (int): The total number of versions (1 to n)
  - `firstBad` (int): The first bad version number (for simulation purposes)
- **Output:** (int) The first bad version number

## Test Cases

| n | firstBad | Expected Output |
|---|----------|-----------------|
| 5 | 4 | 4 |
| 1 | 1 | 1 |
| 10 | 10 | 10 |
| 100 | 75 | 75 |
| 50 | 1 | 1 |

## Algorithm
Use binary search to minimize API calls:
1. Initialize `left = 1`, `right = n`
2. While `left < right`:
   - Calculate `mid = left + (right - left) / 2` (to avoid overflow)
   - If `isBadVersion(mid)` is true, the first bad is at or before `mid`: set `right = mid`
   - Else, the first bad is after `mid`: set `left = mid + 1`
3. Return `left` (or `right`, they're equal)

Time Complexity: O(log n)
Space Complexity: O(1)
