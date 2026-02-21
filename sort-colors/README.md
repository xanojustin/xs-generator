# Sort Colors (Dutch National Flag)

## Problem

Given an array `nums` containing only the values 0, 1, and 2, sort the array **in-place** such that all 0s come first, followed by all 1s, followed by all 2s.

This is known as the **Dutch National Flag problem**, originally proposed by Edsger Dijkstra. The challenge is to solve it with a single pass through the array using only constant extra space (O(1) space complexity).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sort-colors.xs`):** Contains the Dutch National Flag algorithm implementation

## Function Signature

- **Input:** `int[] nums` - An array containing only the integers 0, 1, and 2 (may be unsorted)
- **Output:** `int[]` - The sorted array with all 0s first, then 1s, then 2s

## Algorithm Explanation

The Dutch National Flag algorithm uses three pointers:
- **`low`**: Boundary of 0s (everything before `low` is 0)
- **`mid`**: Current element being examined
- **`high`**: Boundary of 2s (everything after `high` is 2)

**Rules:**
- When `nums[mid] == 0`: swap with `nums[low]`, increment both `low` and `mid`
- When `nums[mid] == 1`: just increment `mid` (1s are in the middle zone)
- When `nums[mid] == 2`: swap with `nums[high]`, decrement `high` (don't increment `mid` because we need to check the swapped element)

**Time Complexity:** O(n) - single pass through the array  
**Space Complexity:** O(1) - only three pointers used

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[2, 0, 2, 1, 1, 0]` | `[0, 0, 1, 1, 2, 2]` |
| `[2, 0, 1]` | `[0, 1, 2]` |
| `[]` | `[]` |
| `[0]` | `[0]` |
| `[1, 1, 1]` | `[1, 1, 1]` |
| `[2, 2, 2, 1, 1, 0, 0]` | `[0, 0, 1, 1, 2, 2, 2]` |

### Edge Cases Covered
- **Empty array:** Returns empty array
- **Single element:** Already sorted
- **Already sorted:** Returns same array
- **Reverse sorted:** `[2, 2, 2, 1, 1, 0, 0]` 
- **All same values:** `[1, 1, 1]` remains `[1, 1, 1]`

## References

- Originally proposed by Edsger Dijkstra in "A Discipline of Programming" (1976)
- Common interview question at companies like Amazon, Google, Microsoft
