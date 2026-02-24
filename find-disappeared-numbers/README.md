# Find All Numbers Disappeared in an Array

## Problem

Given an array `nums` of `n` integers where `nums[i]` is in the range `[1, n]`, return an array of all the integers in the range `[1, n]` that do **not** appear in `nums`.

### Constraints:
- `n == nums.length`
- `1 <= n <= 10^5`
- `1 <= nums[i] <= n`

### Follow-up:
Could you do it without extra space and in O(n) runtime? You may assume the returned list does not count as extra space.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_disappeared_numbers.xs`):** Contains the solution logic using the "mark as negative" technique

## Function Signature

- **Input:**
  - `nums` (int[]): Array of integers where `1 <= nums[i] <= nums.length`
  
- **Output:**
  - Returns (int[]): Array of integers in range `[1, n]` that do not appear in the input array

## Algorithm Explanation

This solution uses the **"mark as negative"** technique to achieve O(n) time complexity and O(1) space complexity (excluding the output array):

1. **Phase 1 - Marking:** For each number in the array, use its absolute value to determine which index to mark. Negate the value at that target index to indicate the number was "seen".

2. **Phase 2 - Collection:** After marking, iterate through the array again. Any positive value at index `i` means the number `(i + 1)` was never seen, so it belongs in the result.

### Example Walkthrough:
```
Input: [4, 3, 2, 7, 8, 2, 3, 1]

After marking phase:
[-4, -3, -2, -7, 8, 2, -3, -1]
          ↑     ↑
       Indices 4 and 5 are positive (0-indexed)

Output: [5, 6]  // (4+1, 5+1)
```

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[4, 3, 2, 7, 8, 2, 3, 1]` | `[5, 6]` |
| `[1, 1]` | `[2]` |
| `[]` | `[]` |
| `[1, 2, 3, 4, 5]` | `[]` |

### Test Case Descriptions:

1. **Basic case:** `[4, 3, 2, 7, 8, 2, 3, 1]` → `[5, 6]`
   - Classic example with duplicates (2 appears twice, 3 appears twice)
   - Missing numbers are 5 and 6

2. **All duplicates:** `[1, 1]` → `[2]`
   - Only one unique number, missing the other

3. **Empty array:** `[]` → `[]`
   - Edge case: empty input returns empty output

4. **Complete set:** `[1, 2, 3, 4, 5]` → `[]`
   - All numbers present, no missing values

## Complexity Analysis

- **Time Complexity:** O(n) - Single pass to mark, single pass to collect
- **Space Complexity:** O(1) auxiliary - Modifies input array in place, only uses the output array for results
