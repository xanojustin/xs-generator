# Fraction to Recurring Decimal

## Problem
Given two integers representing the numerator and denominator of a fraction, return the fraction in string format.

If the fractional part is repeating, enclose the repeating part in parentheses.

If multiple answers are possible for any test case, any of the acceptable answers will be accepted.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/fraction_to_recurring_decimal.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `numerator` (int): The numerator of the fraction
  - `denominator` (int): The denominator of the fraction (non-zero)
- **Output:** (text) The decimal representation of the fraction, with repeating parts enclosed in parentheses

## Test Cases

| Input (numerator, denominator) | Expected Output |
|--------------------------------|-----------------|
| (1, 2) | `"0.5"` |
| (2, 1) | `"2"` |
| (4, 2) | `"2"` |
| (1, 3) | `"0.(3)"` |
| (2, 3) | `"0.(6)"` |
| (4, 333) | `"0.(012)"` |
| (1, 6) | `"0.1(6)"` |
| (0, 1) | `"0"` |
| (-1, 2) | `"-0.5"` |
| (1, -2) | `"-0.5"` |
| (-1, -2) | `"0.5"` |
| (1, 7) | `"0.(142857)"` |

## Algorithm Explanation

The solution uses long division to convert the fraction to decimal:

1. **Handle edge cases**: If numerator is 0, return "0"
2. **Determine sign**: Check if result should be negative (XOR of signs)
3. **Extract integer part**: Use integer division to get the whole number part
4. **Long division for fractional part**:
   - Track remainders in a hash map with their position
   - When a remainder repeats, the digits from that position will repeat
   - Insert parentheses around the repeating section
5. **Build result**: Combine integer part, decimal point, and fractional part

**Time Complexity:** O(d) where d is the number of digits in the result
**Space Complexity:** O(d) for storing the remainder map
