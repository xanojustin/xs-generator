# Majority Element

## Problem

Given an array of integers `nums`, find the **majority element** - the element that appears more than `⌊n/2⌋` times, where `n` is the length of the array.

The majority element always exists in the input array (assumption for this exercise). The algorithm must run in O(n) time and O(1) space.

This implementation uses the **Boyer-Moore Voting Algorithm**, which maintains a candidate and a counter. When the counter reaches zero, a new candidate is selected.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input `[3, 2, 3]`
- **Function (`function/majority_element.xs`):** Contains the Boyer-Moore voting algorithm solution

## Function Signature

- **Input:** 
  - `nums` (int[]): Array of integers containing a majority element
- **Output:** 
  - Returns the majority element (int) that appears more than n/2 times, or null if no majority exists

## Algorithm (Boyer-Moore Voting)

1. **Phase 1 - Find Candidate:**
   - Initialize `candidate = null`, `count = 0`
   - For each number:
     - If `count == 0`, set `candidate = current number`
     - If `current == candidate`, increment count
     - Else decrement count

2. **Phase 2 - Verify:**
   - Count occurrences of candidate
   - Return candidate only if it appears > n/2 times

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[3, 2, 3]` | `3` | 3 appears 2 times (> 3/2) |
| `[2, 2, 1, 1, 1, 2, 2]` | `2` | 2 appears 4 times (> 7/2) |
| `[1]` | `1` | Single element is always majority |
| `[1, 1, 1, 2, 2]` | `1` | 1 appears 3 times (> 5/2) |
| `[1, 2, 3]` | `null` | No majority element (each appears once) |

## Complexity

- **Time Complexity:** O(n) - Two passes through the array
- **Space Complexity:** O(1) - Only using a few variables
