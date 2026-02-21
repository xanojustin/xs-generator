# Hamming Distance

## Problem

The **Hamming distance** between two integers is the number of positions at which the corresponding bits are different.

Given two integers `x` and `y`, return the Hamming distance between them.

### Example
- Input: `x = 1`, `y = 4`
- Binary representation: `1 = 0001`, `4 = 0100`
- The bits differ at positions 1 and 3 (0-indexed from right)
- Output: `2`

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs (x=1, y=4)
- **Function (`function/hamming_distance.xs`):** Contains the solution logic using Brian Kernighan's bit counting algorithm

## Function Signature

- **Input:**
  - `x` (int): First integer
  - `y` (int): Second integer
- **Output:**
  - `distance` (int): The number of bit positions where the two integers differ

## Algorithm

The solution uses **Brian Kernighan's Algorithm** to efficiently count set bits:

1. **XOR** the two numbers (`x ^ y`) - this gives a number where each set bit represents a position where the original numbers differed
2. **Count the set bits** in the XOR result by repeatedly clearing the least significant set bit: `n & (n - 1)`

This algorithm is more efficient than checking each bit position individually, especially for sparse bit patterns.

## Test Cases

| Input (x, y) | Binary x | Binary y | Expected Output |
|--------------|----------|----------|-----------------|
| (1, 4) | 0001 | 0100 | 2 |
| (3, 1) | 0011 | 0001 | 1 |
| (0, 0) | 0000 | 0000 | 0 |
| (2^31-1, 0) | 111...111 (31 bits) | 000...000 | 31 |
| (8, 8) | 1000 | 1000 | 0 |

### Edge Cases Covered
- **Basic case:** Two small integers with some differing bits
- **Identical numbers:** Zero distance when bits are the same
- **Zero inputs:** Both zero should return zero
- **Maximum difference:** All bits differ (31 bits for positive integers)
- **Same number:** Distance should be zero

## Complexity Analysis

- **Time Complexity:** O(log(max(x, y))) - proportional to the number of set bits in the XOR result
- **Space Complexity:** O(1) - constant extra space
