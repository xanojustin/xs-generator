# Integer to Roman

## Problem

Given an integer, convert it to a Roman numeral.

Roman numerals are represented by seven different symbols: `I`, `V`, `X`, `L`, `C`, `D`, and `M`.

| Symbol | Value |
|--------|-------|
| I      | 1     |
| V      | 5     |
| X      | 10    |
| L      | 50    |
| C      | 100   |
| D      | 500   |
| M      | 1000  |

Roman numerals are written from largest to smallest from left to right. However, there are special cases where subtraction is used:
- `IV` = 4 (5 - 1)
- `IX` = 9 (10 - 1)
- `XL` = 40 (50 - 10)
- `XC` = 90 (100 - 10)
- `CD` = 400 (500 - 100)
- `CM` = 900 (1000 - 100)

For example, 1994 is written as `MCMXCIV` (1000 + 900 + 90 + 4).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with a test input (1994)
- **Function (`function/integer-to-roman.xs`):** Contains the solution logic for converting integers to Roman numerals

## Function Signature

- **Input:** `number` (int) - The integer to convert (1 to 3999)
- **Output:** (text) - The Roman numeral representation as a string

## Algorithm

The solution uses a greedy approach with ordered Roman numeral values:
1. Define the Roman numeral values and symbols in descending order
2. For each value (starting from largest), repeatedly subtract it from the input while appending the corresponding symbol
3. Continue until the input is reduced to zero

This approach efficiently builds the Roman numeral by always using the largest possible symbol at each step.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 3     | "III"           |
| 58    | "LVIII"         |
| 1     | "I"             |
| 1994  | "MCMXCIV"       |

### Test Case Details

1. **Basic case (3):** Simple repetition - III = 1 + 1 + 1
2. **Complex case (58):** Combination - LVIII = 50 + 5 + 1 + 1 + 1
3. **Edge case (1):** Minimum valid input - I
4. **Boundary case (1994):** Multiple subtractive pairs - MCMXCIV = 1000 + 900 + 90 + 4

The run job tests with input 1994, which exercises multiple subtractive pairs (CM, XC, IV).

## Time & Space Complexity

- **Time Complexity:** O(1) - The number of Roman numeral symbols is constant (13), and each symbol is checked at most once per digit place
- **Space Complexity:** O(1) - The result string has a maximum length of 15 characters for valid inputs
