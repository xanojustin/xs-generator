# Confusing Number

## Problem

A **confusing number** is a number that, when rotated 180 degrees, becomes a different valid number.

When a number is rotated 180 degrees:
- `0` becomes `0`
- `1` becomes `1`
- `6` becomes `9`
- `8` becomes `8`
- `9` becomes `6`

Digits `2`, `3`, `4`, `5`, and `7` become invalid when rotated.

Given a number `n`, determine if it is a confusing number (returns `true`) or not (returns `false`).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/confusing_number.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `n` (int): A non-negative integer to check
- **Output:** 
  - (bool): `true` if the number is confusing (rotates to a different valid number), `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 6 | true | Rotates to 9 (different valid number) |
| 89 | true | Rotates to 68 (different valid number) |
| 11 | false | Rotates to 11 (same number) |
| 25 | false | Contains 5, which is invalid when rotated |
| 0 | false | Rotates to 0 (same number) |
| 1 | false | Rotates to 1 (same number) |
| 69 | true | Rotates to 96 (different valid number) |
| 88 | false | Rotates to 88 (same number) |
| 916 | true | Rotates to 619 (different valid number) |

## Examples

```
Input: 6
Output: true
Explanation: We rotate 6 by 180 degrees to get 9, which is different from 6 but still valid.

Input: 89
Output: true
Explanation: We rotate 89 by 180 degrees to get 68, which is different from 89 but still valid.

Input: 11
Output: false
Explanation: We rotate 11 by 180 degrees to get 11, which is the same as the original number.
```
