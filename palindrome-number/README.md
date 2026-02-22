# Palindrome Number

## Problem
Determine whether an integer is a palindrome. An integer is a palindrome when it reads the same backward as forward.

**Examples:**
- Input: 121 → Output: true (reads the same forwards and backwards)
- Input: 123 → Output: false (reads differently backwards: 321)
- Input: -121 → Output: false (negative numbers are not palindromes due to the minus sign)

**Follow-up:** Could you solve this without converting the integer to a string?

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/palindrome-number.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `num` (integer): The integer to check
- **Output:** 
  - `is_palindrome` (boolean): `true` if the number is a palindrome, `false` otherwise

## Test Cases
| Input | Expected Output | Notes |
|-------|-----------------|-------|
| 121 | true | Basic palindrome (odd number of digits) |
| 123 | false | Not a palindrome |
| 7 | true | Single digit (always palindrome) |
| -121 | false | Negative numbers are not palindromes |
| 12321 | true | Larger palindrome |
| 10 | false | Ends with zero, reversed starts with zero |

## Algorithm
The solution converts the number to a string and compares it with its reverse:
1. Handle edge case: negative numbers are never palindromes
2. Convert the number to a string
3. Reverse the string
4. Compare original with reversed

**Time Complexity:** O(n) where n is the number of digits
**Space Complexity:** O(n) for the string conversion
