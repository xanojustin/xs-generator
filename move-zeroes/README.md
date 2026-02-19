# Move Zeroes

## Problem

Given an integer array `nums`, move all `0`'s to the end of it while maintaining the relative order of the non-zero elements.

**Note:** You must do this in-place without making a copy of the array. However, since XanoScript passes arrays by value, we simulate this by returning the modified array.

This is a classic array manipulation problem often asked in coding interviews. It tests your understanding of:
- Array traversal
- Two-pointer technique
- In-place modification

## Function Signature

- **Input:** `nums` (int[]) - An array of integers that may contain zeros
- **Output:** `int[]` - The same array with all zeros moved to the end, preserving the relative order of non-zero elements

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[0, 1, 0, 3, 12]` | `[1, 3, 12, 0, 0]` |
| `[0, 0, 1]` | `[1, 0, 0]` |
| `[1, 2, 3]` | `[1, 2, 3]` |
| `[0, 0, 0]` | `[0, 0, 0]` |
| `[]` | `[]` |
| `[1]` | `[1]` |
| `[0]` | `[0]` |
| `[1, 0, 2, 0, 3, 0, 4]` | `[1, 2, 3, 4, 0, 0, 0]` |

### Edge Cases Explained

1. **Empty array `[]`**: Should return empty array - tests boundary condition
2. **All zeros `[0, 0, 0]`**: Should return unchanged - tests when no movement needed
3. **No zeros `[1, 2, 3]`**: Should return unchanged - tests when no movement needed
4. **Single element `[0]` or `[1]`**: Tests minimum input size
5. **Alternating zeros `[1, 0, 2, 0, 3, 0, 4]`**: Tests multiple zeros scattered throughout array
6. **Zeros at start `[0, 0, 1]`**: Tests when all zeros are at the beginning

## Algorithm Explanation

This solution uses the **two-pointer technique**:

1. **First Pass (Non-zero collection):**
   - Use pointer `insert_pos` to track where the next non-zero element should go
   - Iterate through the array with pointer `i`
   - When a non-zero element is found, place it at `insert_pos` and increment `insert_pos`

2. **Second Pass (Zero fill):**
   - Starting from `insert_pos`, fill the remaining positions with zeros

**Time Complexity:** O(n) - We traverse the array twice at most
**Space Complexity:** O(1) - We only use a few variables (though the array is technically copied in XanoScript)
