# Find the Duplicate Number

## Problem

Given an array containing `n + 1` integers where each integer is between `1` and `n` (inclusive), prove that at least one duplicate number must exist. Assume that there is only one duplicate number, find it.

**Constraints:**
- You must not modify the array (assume the array is read only)
- You must use only constant, O(1) extra space
- Your runtime complexity should be less than O(n²)
- There is only one duplicate number in the array, but it could be repeated more than once

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_duplicate_number.xs`):** Contains the Floyd's Cycle Detection (Tortoise and Hare) algorithm

## Function Signature

- **Input:**
  - `nums` (int[]): Array of n+1 integers where each integer is between 1 and n
- **Output:**
  - `duplicate` (int): The duplicate number in the array

## Algorithm Explanation

This solution uses **Floyd's Cycle Detection Algorithm** (also known as the Tortoise and Hare algorithm):

1. **Phase 1 - Find Intersection:**
   - Treat the array values as pointers (value at index `i` points to index `nums[i]`)
   - Since there's a duplicate, there must be a cycle in this "linked list"
   - Move slow pointer 1 step at a time, fast pointer 2 steps at a time
   - They will eventually meet inside the cycle

2. **Phase 2 - Find Cycle Entrance:**
   - Reset one pointer to the start
   - Move both pointers 1 step at a time
   - The point where they meet again is the duplicate number (cycle entrance)

**Time Complexity:** O(n)  
**Space Complexity:** O(1)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 3, 4, 2, 2]` | `2` | The duplicate is 2 |
| `[3, 1, 3, 4, 2]` | `3` | The duplicate is 3 |
| `[1, 1]` | `1` | Minimal case with two elements |
| `[2, 2, 2, 2, 2]` | `2` | All same values (duplicate repeated multiple times) |
| `[1, 4, 4, 2, 4]` | `4` | Duplicate appears more than twice |

## Example Walkthrough

For input `[1, 3, 4, 2, 2]`:
- Array indices: 0, 1, 2, 3, 4
- Array values:  1, 3, 4, 2, 2

Treating values as pointers:
- 0 → 1 → 3 → 2 → 4 → 2 (cycle detected!)

Phase 1: Slow and fast pointers meet at some point in the cycle
Phase 2: Reset one pointer, both move at same speed, meet at the entrance (2)
