# Plus One

## Problem
Given a non-empty array of digits representing a non-negative integer, add one to the integer.

The digits are stored such that the most significant digit is at the head of the list, and each element in the array contains a single digit.

You may assume the integer does not contain any leading zero, except the number 0 itself.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/plus_one.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `digits` (int[]): An array of digits representing a non-negative integer
- **Output:** 
  - int[]: An array of digits representing the input number plus one

## Algorithm
1. Start from the rightmost digit (least significant)
2. Add 1 to the current digit with carry propagation
3. If the sum is 10 or more, set the digit to (sum % 10) and continue to the next digit with carry = 1
4. If there's still a carry after processing all digits, prepend 1 to the result

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| [1, 2, 3] | [1, 2, 4] | 123 + 1 = 124 |
| [4, 3, 2, 1] | [4, 3, 2, 2] | 4321 + 1 = 4322 |
| [9] | [1, 0] | 9 + 1 = 10 |
| [9, 9, 9] | [1, 0, 0, 0] | 999 + 1 = 1000 |
| [0] | [1] | 0 + 1 = 1 |
| [1, 9, 9] | [2, 0, 0] | 199 + 1 = 200 |

## Example Walkthrough

**Input:** `[1, 2, 9]`

1. Start with i = 2 (last index), carry = 1
2. 9 + 1 = 10 → digit becomes 0, carry = 1, i = 1
3. 2 + 1 = 3 → digit becomes 3, carry = 0, done
4. **Result:** `[1, 3, 0]`

**Input:** `[9, 9]`

1. Start with i = 1, carry = 1
2. 9 + 1 = 10 → digit becomes 0, carry = 1, i = 0
3. 9 + 1 = 10 → digit becomes 0, carry = 1, i = -1
4. Still have carry = 1, prepend 1 → **Result:** `[1, 0, 0]`
