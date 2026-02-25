# Majority Element II

## Problem

Given an integer array of size `n`, find all elements that appear more than `⌊ n/3 ⌋` times.

The algorithm should run in **linear time** and in **O(1) space**.

### Example 1:
- **Input:** `nums = [3, 2, 3]`
- **Output:** `[3]`

### Example 2:
- **Input:** `nums = [1]`
- **Output:** `[1]`

### Example 3:
- **Input:** `nums = [1, 2]`
- **Output:** `[1, 2]`

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/majority_element_ii.xs`):** Contains the Boyer-Moore Voting Algorithm solution

## Function Signature

- **Input:** 
  - `nums` (int[]): Array of integers to analyze
- **Output:** 
  - Returns (int[]): Array of all majority elements (appearing more than n/3 times), in any order

## Algorithm Explanation

This solution uses the **Boyer-Moore Voting Algorithm**:

1. **Key Insight:** If an element appears more than n/3 times, there can be at most 2 such elements.

2. **First Pass:** Find up to 2 potential candidates by:
   - Maintaining 2 counters for 2 candidates
   - When seeing a number that matches either candidate, increment that counter
   - When both counters are zero, pick the current number as a new candidate
   - Otherwise, decrement both counters

3. **Second Pass:** Verify each candidate by counting actual occurrences in the array.

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| `[3, 2, 3]` | `[3]` | Basic case - one majority element |
| `[1]` | `[1]` | Single element edge case |
| `[1, 2]` | `[1, 2]` | Both elements are majority (each > 2/3 is not possible, but > n/3 = 0.66...) |
| `[2, 2, 1, 3]` | `[2]` | 2 appears 2 times (> 4/3 = 1.33) |
| `[2, 2, 9, 3, 9, 3, 9, 3, 9, 3, 9]` | `[9, 3]` | Two majority elements |
| `[]` | `[]` | Empty array edge case |
| `[1, 1, 1, 2, 2, 2, 3, 3, 3]` | `[]` | No majority element (each appears exactly n/3 times) |

## Constraints

- `1 <= nums.length <= 5 * 10^4`
- `-10^9 <= nums[i] <= 10^9`
- The solution should run in O(n) time and use O(1) extra space
