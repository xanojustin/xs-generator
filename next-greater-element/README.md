# Next Greater Element

## Problem
Given an array of integers, find the next greater element for each element in the array.

The **next greater element** for an element `x` is the first element to the right of `x` in the array that is greater than `x`.

If no such element exists, the output should be `-1` for that position.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/next_greater_element.xs`):** Contains the solution logic using a monotonic stack

## Function Signature
- **Input:** `int[] nums` - An array of integers
- **Output:** `int[]` - An array where each element at index `i` is the next greater element for `nums[i]`, or `-1` if none exists

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[4, 5, 2, 25]` | `[5, 25, 25, -1]` |
| `[13, 7, 6, 12]` | `[-1, 12, 12, -1]` |
| `[]` | `[]` |
| `[1, 2, 3, 4, 5]` | `[2, 3, 4, 5, -1]` |
| `[5, 4, 3, 2, 1]` | `[-1, -1, -1, -1, -1]` |

### Explanation of Test Cases:
1. **Basic case:** For `4`, next greater is `5`; for `5`, next greater is `25`; for `2`, next greater is `25`; for `25`, no greater element exists so `-1`
2. **Mixed case:** For `13`, no greater element exists; for `7`, next greater is `12`; for `6`, next greater is `12`; for `12`, no greater element exists
3. **Edge case - Empty array:** Returns empty array
4. **Ascending order:** Each element has a next greater element except the last
5. **Descending order:** No element has a next greater element

## Algorithm
This solution uses a **monotonic stack** approach:
1. Initialize result array with `-1` for all positions
2. Use a stack to keep track of indices whose next greater element hasn't been found yet
3. For each element, while the stack is not empty and current element is greater than the element at the index on top of stack:
   - Pop from stack and set current element as the next greater for the popped index
4. Push current index onto stack
5. Remaining indices in stack have no next greater element (already initialized to `-1`)

**Time Complexity:** O(n) - Each element is pushed and popped from the stack at most once
**Space Complexity:** O(n) - For the stack and result array
