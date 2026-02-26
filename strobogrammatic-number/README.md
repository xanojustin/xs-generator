# Strobogrammatic Number

## Problem
A strobogrammatic number is a number that looks the same when rotated 180 degrees (upside down). Given a string representing a number, determine if it is strobogrammatic.

Valid strobogrammatic digit pairs:
- `0` rotates to `0`
- `1` rotates to `1`
- `6` rotates to `9`
- `8` rotates to `8`
- `9` rotates to `6`

Digits `2`, `3`, `4`, `5`, and `7` are invalid as they don't form valid numbers when rotated.

## Structure
- **Run Job (`run.xs`):** Calls the test function which runs multiple test cases
- **Function (`function/is_strobogrammatic.xs`):** Contains the solution logic that checks if a single number is strobogrammatic
- **Function (`function/test_strobogrammatic.xs`):** Test harness that calls the solution with various test inputs

## Function Signature
- **Input:** `text number` - The number to check as a string (e.g., "69", "818")
- **Output:** `bool` - `true` if the number is strobogrammatic, `false` otherwise

## Test Cases

| Input | Expected Output | Reason |
|-------|-----------------|--------|
| `"69"` | `true` | 6→9 and 9→6, reads same rotated |
| `"88"` | `true` | 8→8, reads same rotated |
| `"818"` | `true` | 8→8, 1→1, 8→8 |
| `"6969"` | `true` | 6↔9 pairs symmetrically |
| `"1"` | `true` | Single digit 1 is strobogrammatic |
| `"123"` | `false` | 2 is not a valid strobogrammatic digit |
| `"2"` | `false` | 2 is not a valid strobogrammatic digit |

## Algorithm
The solution uses a two-pointer approach:
1. Define the strobogrammatic digit pairs (0→0, 1→1, 6→9, 8→8, 9→6)
2. Use two pointers: one at the start (`left`) and one at the end (`right`)
3. For each pair of digits:
   - Check if the left digit has a valid strobogrammatic pair
   - Check if the left digit's pair equals the right digit
   - If either check fails, return `false`
4. Move pointers toward the center
5. If all pairs match, return `true`

Time Complexity: O(n) where n is the number of digits
Space Complexity: O(1) - only storing the pair mapping
