# Roman Numeral Conversion

## Problem

Convert a positive integer (1-3999) to its Roman numeral representation.

Roman numerals are represented by seven different symbols:
- **I** = 1
- **V** = 5
- **X** = 10
- **L** = 50
- **C** = 100
- **D** = 500
- **M** = 1000

Special subtractive combinations:
- **IV** = 4 (5 - 1)
- **IX** = 9 (10 - 1)
- **XL** = 40 (50 - 10)
- **XC** = 90 (100 - 10)
- **CD** = 400 (500 - 100)
- **CM** = 900 (1000 - 100)

Numbers are formed by combining symbols and adding their values. Symbols are placed from left to right in descending order of value.

## Function Signature

- **Input:** `number` (int) - The integer to convert (must be between 1 and 3999, inclusive)
- **Output:** `text` - The Roman numeral representation as a string

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 1 | `"I"` |
| 3 | `"III"` |
| 4 | `"IV"` |
| 9 | `"IX"` |
| 58 | `"LVIII"` |
| 199 | `"CXCIX"` |
| 1994 | `"MCMXCIV"` |
| 3999 | `"MMMCMXCIX"` |

### Edge Cases Explained

1. **number = 1**: Single symbol "I" - tests the minimum valid input
2. **number = 4**: Subtractive notation "IV" - tests the first special case
3. **number = 9**: Subtractive notation "IX" - tests another special case
4. **number = 3999**: Maximum standard Roman numeral "MMMCMXCIX" - tests upper boundary with multiple subtractive notations
5. **number = 0**: Should fail validation since minimum is 1
6. **number = 4000**: Should fail validation since maximum is 3999
