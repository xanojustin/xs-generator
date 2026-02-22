# String to Integer (atoi)

## Problem

Implement the `myAtoi(string s)` function, which converts a string to a 32-bit signed integer (similar to C/C++'s `atoi` function).

The algorithm for `myAtoi(string s)` is as follows:

1. **Read in and ignore any leading whitespace**.
2. Check if the next character (if not already at the end of the string) is `'-'` or `'+'`. Read this character in if it is either. This determines if the final result is negative or positive respectively. Assume the result is positive if neither is present.
3. **Read in next the characters until the next non-digit character** or the end of the input is reached. The rest of the string is ignored.
4. **Convert these digits into an integer** (i.e. `"123" -> 123`, `"0032" -> 32`). If no digits were read, then the integer is `0`.
5. **Change the sign** as necessary (from step 2).
6. **Clamp the integer** to the 32-bit signed integer range `[-2^31, 2^31 - 1]`. If the number is outside this range, clamp it to the boundary value.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/string_to_integer_atoi.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `s` (text): The string to convert to integer
- **Output:** 
  - (int): The converted 32-bit signed integer, or 0 if no valid conversion

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"42"` | `42` | Basic positive number |
| `"   -42"` | `-42` | Leading whitespace with negative sign |
| `"4193 with words"` | `4193` | Stops at first non-digit character |
| `"words and 987"` | `0` | No valid digits at start |
| `"-91283472332"` | `-2147483648` | Negative overflow (INT_MIN) |
| `"91283472332"` | `2147483647` | Positive overflow (INT_MAX) |
| `"+123"` | `123` | Explicit positive sign |
| `"0"` | `0` | Single zero |
| `"  000123"` | `123` | Leading zeros with whitespace |
| `""` | `0` | Empty string |
| `"+-12"` | `0` | Invalid: sign followed by another sign |
| `"   "` | `0` | Only whitespace |

## Key Concepts Demonstrated

- String character iteration and parsing
- Whitespace handling and trimming
- Sign detection and handling
- Digit validation and conversion
- Integer overflow detection and clamping
- 32-bit signed integer boundaries
