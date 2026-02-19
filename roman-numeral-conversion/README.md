# Roman Numeral Conversion

## Problem
Convert a given integer (1-3999) to its Roman numeral representation.

Roman numerals are represented by seven different symbols: I, V, X, L, C, D, and M.

| Symbol | Value |
|--------|-------|
| I | 1 |
| V | 5 |
| X | 10 |
| L | 50 |
| C | 100 |
| D | 500 |
| M | 1000 |

Roman numerals are usually written largest to smallest from left to right. However, subtractive notation is used for numbers like 4 (IV) and 9 (IX):
- IV = 4 (5 - 1)
- IX = 9 (10 - 1)
- XL = 40 (50 - 10)
- XC = 90 (100 - 10)
- CD = 400 (500 - 100)
- CM = 900 (1000 - 100)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/roman_numeral.xs`):** Contains the solution logic

## Function Signature
- **Input:** `number` (int) - The integer to convert (valid range: 1-3999)
- **Output:** (text) - The Roman numeral string representation

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 3 | "III" |
| 4 | "IV" |
| 9 | "IX" |
| 58 | "LVIII" |
| 1994 | "MCMXCIV" |
| 3999 | "MMMCMXCIX" |

### Basic Cases
- **3 → "III"**: Simple repetition of I
- **58 → "LVIII"**: L (50) + V (5) + III (3)

### Edge Cases  
- **4 → "IV"**: Subtractive notation (5 - 1)
- **9 → "IX"**: Subtractive notation (10 - 1)

### Boundary/Complex Cases
- **1994 → "MCMXCIV"**: M (1000) + CM (900) + XC (90) + IV (4)
- **3999 → "MMMCMXCIX"**: Maximum valid input (three Ms + CM + XC + IX)
