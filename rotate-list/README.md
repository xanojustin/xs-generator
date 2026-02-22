# Rotate List

## Problem
Given the head of a linked list, rotate the list to the right by `k` places.

For example, given the list `[1, 2, 3, 4, 5]` and `k = 2`, rotate it to the right by 2 places:
- After 1st rotation: `[5, 1, 2, 3, 4]`
- After 2nd rotation: `[4, 5, 1, 2, 3]`

So the result is `[4, 5, 1, 2, 3]`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/rotate_list.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `head` (int[]): Array representing the linked list values
  - `k` (int): Number of places to rotate right
- **Output:** (int[]): The rotated list as an array

## Approach
1. Handle edge cases: empty list, single element, or k <= 0
2. Calculate effective rotation: `k % length` (handles k > length)
3. If effective rotation is 0, return the original list
4. Split the list at position `length - k`
5. Concatenate the second part with the first part

## Test Cases

| Input | k | Expected Output |
|-------|---|-----------------|
| `[1, 2, 3, 4, 5]` | 2 | `[4, 5, 1, 2, 3]` |
| `[0, 1, 2]` | 4 | `[2, 0, 1]` |
| `[1]` | 10 | `[1]` |
| `[]` | 3 | `[]` |
| `[1, 2, 3]` | 0 | `[1, 2, 3]` |
| `[1, 2, 3]` | 3 | `[1, 2, 3]` |

### Explanation of Test Cases
- **Basic case:** `[1, 2, 3, 4, 5]` rotated by 2 → last 2 elements move to front
- **k > length:** `[0, 1, 2]` rotated by 4 is same as rotating by 1 (4 % 3 = 1)
- **Single element:** `[1]` rotated by any amount stays `[1]`
- **Empty list:** `[]` rotated stays `[]`
- **Zero rotation:** No change to the list
- **Full rotation:** Rotating by the list length results in the same list
