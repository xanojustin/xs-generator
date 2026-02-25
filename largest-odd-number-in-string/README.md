# Largest Odd Number in String

## Problem

Given a string `num` representing a large integer, return the **largest odd number** (as a string) that is a non-empty substring of `num`. An integer is odd if its last digit is odd (1, 3, 5, 7, or 9).

Since we want the largest possible number, we should use as many digits as possible from the left side of the string. The key insight is that we only need to find the rightmost odd digit - the substring from the start to that digit will be the largest odd number.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/largest_odd_number.xs`):** Contains the solution logic

## Function Signature

- **Input:** `text num` - A string representing a non-negative integer (1 ≤ length ≤ 10^5)
- **Output:** `text` - The largest odd number substring, or empty string if no odd number exists

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"52"` | `"5"` | The rightmost odd digit is '5' at index 0, so we take substring "5" |
| `"4206"` | `""` | No odd digits exist, so return empty string |
| `"35427"` | `"35427"` | The last digit '7' is odd, so the entire string is the largest odd number |
| `"10133890"` | `"1013389"` | The rightmost odd digit is '9' at index 6 |
| `"1"` | `"1"` | Single odd digit - the number itself |
| `"8"` | `""` | Single even digit - no odd number possible |

## Algorithm

1. Scan the string from right to left
2. Find the first (rightmost) odd digit
3. Return the substring from index 0 to that position (inclusive)
4. If no odd digit is found, return empty string

**Time Complexity:** O(n) where n is the length of the string  
**Space Complexity:** O(1) - only using a few variables
