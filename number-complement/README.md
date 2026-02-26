# Number Complement

## Problem
Given a positive integer, output its complement number. The complement strategy is to flip the bits of its binary representation.

For example:
- Input: 5 (binary: `101`)
- Output: 2 (binary: `010`)

The complement is calculated by finding the number of bits needed to represent the number, creating a mask of all 1s with that many bits, then subtracting the original number from the mask.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/number_complement.xs`):** Contains the solution logic

## Function Signature
- **Input:** `num` (int) - A positive integer (≥ 1)
- **Output:** (int) - The complement of the input number

## Test Cases

| Input | Binary | Mask | Expected Output |
|-------|--------|------|-----------------|
| 5 | 101 | 111 (7) | 2 |
| 1 | 1 | 1 (1) | 0 |
| 8 | 1000 | 1111 (15) | 7 |
| 10 | 1010 | 1111 (15) | 5 |
| 7 | 111 | 111 (7) | 0 |

### Edge Cases
- **Single bit numbers:** When num = 1, the complement is 0
- **Power of 2:** Numbers like 8 (1000) have complements that are one less than the next power of 2
- **All 1s:** When num = 7 (111), the complement is 0 since all bits flip to 0
