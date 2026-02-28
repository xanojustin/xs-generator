# Maximum 69 Number

## Problem
Given a positive integer `num` consisting only of digits 6 and 9, return the maximum number you can get by changing at most one digit (6 becomes 9, and 9 becomes 6).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/maximum_69_number.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `num` (int): A positive integer containing only digits 6 and 9
- **Output:** 
  - (int): The maximum possible number after changing at most one 6 to 9

## Algorithm
1. Convert the number to a string
2. Find the first occurrence of '6' (leftmost has highest place value)
3. If a '6' is found, replace it with '9'
4. Return the resulting number

The leftmost '6' has the highest place value, so changing it to '9' yields the maximum increase.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 9669 | 9969 | Change second digit (6) to 9 |
| 9996 | 9999 | Change last digit (6) to 9 |
| 9999 | 9999 | No change needed (no 6s) |
| 6 | 9 | Change the only digit |
| 69 | 99 | Change first digit (6) to 9 |
| 96 | 99 | Change second digit (6) to 9 |

## Examples

**Example 1:**
```
Input: num = 9669
Output: 9969
Explanation: 
- Changing first digit: 6669
- Changing second digit: 9969  ✓ (maximum)
- Changing third digit: 9699
- Changing fourth digit: 9666
```

**Example 2:**
```
Input: num = 9996
Output: 9999
Explanation: Changing the last digit 6 to 9 results in the maximum number.
```

**Example 3:**
```
Input: num = 9999
Output: 9999
Explanation: No 6s to change, return original number.
```
