# Leap Year

## Problem

Write a function that determines if a given year is a leap year.

**Leap year rules:**
- A year is a leap year if it is divisible by 4
- EXCEPT if it is divisible by 100, in which case it is NOT a leap year
- UNLESS it is also divisible by 400, in which case it IS a leap year

**Examples:**
- 2024 is a leap year (divisible by 4, not by 100)
- 1900 is NOT a leap year (divisible by 100, not by 400)
- 2000 IS a leap year (divisible by 400)
- 2023 is NOT a leap year (not divisible by 4)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_leap_year.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `year` (int): The year to check
- **Output:** 
  - `bool`: `true` if the year is a leap year, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 2024 | `true` | Divisible by 4, not by 100 |
| 2023 | `false` | Not divisible by 4 |
| 2000 | `true` | Divisible by 400 |
| 1900 | `false` | Divisible by 100 but not 400 |
| 1600 | `true` | Divisible by 400 |
| 1700 | `false` | Divisible by 100 but not 400 |
| 4 | `true` | Minimum leap year (divisible by 4) |
| 1 | `false` | Not divisible by 4 |

### Test Case Descriptions

1. **Basic leap year (2024):** Standard leap year, divisible by 4 only
2. **Non-leap year (2023):** Regular year not meeting any leap year criteria
3. **Century leap year (2000):** Divisible by 400, so it's a leap year despite being a century
4. **Century non-leap year (1900):** Divisible by 100 but not 400, so NOT a leap year
5. **Another century leap (1600):** Additional 400-divisible test
6. **Another century non-leap (1700):** Additional 100-but-not-400 test
7. **Minimum leap year (4):** Edge case - smallest positive leap year
8. **Small non-leap (1):** Edge case - year 1 is not a leap year
