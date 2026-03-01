# Kth Missing Positive Number

## Problem
Given a **strictly increasing** sorted array of positive integers `arr` and a positive integer `k`, find the **kth** positive integer that is missing from this array.

### Examples
- **Example 1:** `arr = [2,3,4,7,11]`, `k = 5` → Output: `9`
  - Missing positive integers: `[1,5,6,8,9,10,12,...]`
  - The 5th missing positive integer is `9`

- **Example 2:** `arr = [1,2,3,4]`, `k = 2` → Output: `6`
  - Missing positive integers: `[5,6,7,...]`
  - The 2nd missing positive integer is `6`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/kth_missing_positive_number.xs`):** Contains the solution logic using binary search

## Function Signature
- **Input:**
  - `arr` (int[]): A sorted array of positive integers in strictly increasing order
  - `k` (int): The position of the missing positive integer to find
- **Output:**
  - Returns an `int` representing the kth missing positive integer

## Algorithm Explanation
The key insight is that for any index `i` in the array, the number of missing positive integers **before** `arr[i]` is:
```
missing_count(i) = arr[i] - i - 1
```

For example, if `arr[3] = 7` (0-indexed), then:
- Ideally, position 3 should have value 4 (since we expect 1,2,3,4,...)
- But it has 7, so missing_count = 7 - 3 - 1 = 3 (missing: 4, 5, 6)

Using binary search, we find the smallest index where `missing_count >= k`. The kth missing number is then:
```
result = left + k
```

**Time Complexity:** O(log n) where n is the length of the array  
**Space Complexity:** O(1)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `arr = [2,3,4,7,11], k = 5` | `9` | Missing: [1,5,6,8,**9**,10,12...], 5th is 9 |
| `arr = [1,2,3,4], k = 2` | `6` | Missing: [5,**6**,7,8...], 2nd is 6 |
| `arr = [], k = 5` | `5` | Empty array: 1,2,3,4,**5** - 5th missing is 5 |
| `arr = [1], k = 1` | `2` | Missing: [**2**,3,4...], 1st is 2 |
| `arr = [3], k = 2` | `2` | Missing: [1,**2**,4,5...], 2nd is 2 |
| `arr = [2,4,5,6], k = 3` | `7` | Missing: [1,3,**7**,8...], 3rd is 7 |

## Constraints
- 1 ≤ arr.length ≤ 1000
- 1 ≤ arr[i] ≤ 1000
- 1 ≤ k ≤ 1000
- arr is sorted in strictly increasing order
