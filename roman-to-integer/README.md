# Roman to Integer

## Problem
Given a Roman numeral string, convert it to an integer.

Roman numerals are represented by seven different symbols:
| Symbol | Value |
|--------|-------|
| I      | 1     |
| V      | 5     |
| X      | 10    |
| L      | 50    |
| C      | 100   |
| D      | 500   |
| M      | 1000  |

Roman numerals are usually written largest to smallest from left to right. However, there are special cases where subtraction is used:
- I can be placed before V (5) and X (10) to make 4 and 9
- X can be placed before L (50) and C (100) to make 40 and 90
- C can be placed before D (500) and M (1000) to make 400 and 900

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input "MCMXCIV" (1994)
- **Function (`function/roman_to_integer.xs`):** Contains the solution logic using a single-pass approach

## Function Signature
- **Input:** `text roman` - A Roman numeral string containing only valid characters (I, V, X, L, C, D, M)
- **Output:** `int` - The integer value of the Roman numeral

## Algorithm
The solution uses a single-pass approach:
1. Create a mapping of Roman characters to their integer values
2. Iterate through the string from left to right
3. For each character, compare its value with the next character
4. If current < next, subtract current value (subtractive notation)
5. If current >= next, add current value
6. Always add the value of the last character

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| `"III"` | 3 | Simple additive: 1+1+1 |
| `"IV"` | 4 | Subtractive notation: 5-1 |
| `"IX"` | 9 | Subtractive notation: 10-1 |
| `"LVIII"` | 58 | 50 + 5 + 3 = 58 |
| `"MCMXCIV"` | 1994 | 1000 + (1000-100) + (100-10) + (5-1) = 1994 |
| `"MMMCMXCIX"` | 3999 | Maximum standard Roman numeral |
| `""` | 0 | Edge case: empty string |
| `"I"` | 1 | Edge case: single character |
| `"MMXXVI"` | 2026 | Modern year |
