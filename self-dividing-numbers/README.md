# Self-Dividing Numbers

## Problem
A **self-dividing number** is a number that is divisible by every digit it contains.

For example, 128 is a self-dividing number because:
- 128 % 1 == 0
- 128 % 2 == 0
- 128 % 8 == 0

A self-dividing number must not contain the digit zero.

Given the lower and upper bound of a range, return a list of all self-dividing numbers in that range (inclusive), in ascending order.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/self_dividing_numbers.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `left` (int): Lower bound of the range (inclusive)
  - `right` (int): Upper bound of the range (inclusive)
- **Output:** 
  - `int[]`: Array of all self-dividing numbers in the range, sorted in ascending order

## Test Cases

| Input (left, right) | Expected Output |
|---------------------|-----------------|
| (1, 22) | [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 15, 22] |
| (47, 85) | [48, 55, 66, 77] |
| (1, 9) | [1, 2, 3, 4, 5, 6, 7, 8, 9] |
| (10, 10) | [] |
| (100, 130) | [111, 112, 115, 122, 124, 126, 128] |

### Explanation of Test Cases
1. **Basic range (1-22):** Includes single-digit numbers (all self-dividing) and some two-digit numbers like 11, 12, 15, 22
2. **Mid-range (47-85):** Tests various two-digit combinations
3. **Single digits only (1-9):** All single-digit numbers are self-dividing
4. **Edge case - contains zero (10):** 10 contains a 0, so it's not self-dividing
5. **Three-digit numbers (100-130):** Tests three-digit logic, including numbers like 128
