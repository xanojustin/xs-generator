# Binary Gap

## Problem

Given a positive integer `n`, find and return the length of the longest binary gap in its binary representation. A binary gap is any maximal sequence of consecutive zeros that is surrounded by ones at both ends in the binary representation.

## Examples

- **Example 1:** Input `n = 22` (binary `10110`) → Output: `1`
  - The longest binary gap is between the two 1s at positions 0 and 2
  
- **Example 2:** Input `n = 5` (binary `101`) → Output: `1`
  - There is one gap of length 1
  
- **Example 3:** Input `n = 6` (binary `110`) → Output: `0`
  - There are no gaps (no 0s surrounded by 1s on both sides)
  
- **Example 4:** Input `n = 8` (binary `1000`) → Output: `0`
  - The 0s are not surrounded by 1s on the right

## Structure

- **Run Job (`run.xs`):** Calls the `binary_gap` function with test input `n = 22`
- **Function (`function/binary_gap.xs`):** Contains the logic to find the longest binary gap

## Function Signature

- **Input:** 
  - `n` (int): A positive integer (n ≥ 1)
  
- **Output:** 
  - (int): The length of the longest binary gap, or 0 if no binary gap exists

## Algorithm

1. Convert the integer `n` to its binary representation as a string
2. Iterate through each character in the binary string
3. Track when we see a `1` and count consecutive `0`s between `1`s
4. Keep track of the maximum gap length found
5. Return the maximum gap length

## Test Cases

| Input | Binary Representation | Expected Output | Explanation |
|-------|----------------------|-----------------|-------------|
| 22 | 10110 | 1 | Gap of 1 zero between positions 0-2 |
| 5 | 101 | 1 | Single gap of 1 zero |
| 6 | 110 | 0 | Trailing zeros don't count as gap |
| 8 | 1000 | 0 | Trailing zeros don't count as gap |
| 9 | 1001 | 2 | Gap of 2 zeros between two 1s |
| 529 | 1000010001 | 4 | Longest gap is 4 zeros |
| 1041 | 10000010001 | 5 | Longest gap is 5 zeros |
| 1 | 1 | 0 | No zeros at all |
| 2 | 10 | 0 | Single trailing zero |
| 2147483647 | 1111111111111111111111111111111 | 0 | All ones, no gaps |

## Complexity Analysis

- **Time Complexity:** O(log n) - We iterate through the binary representation, which has log₂(n) bits
- **Space Complexity:** O(log n) - We store the binary string representation
