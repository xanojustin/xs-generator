# Total Hamming Distance

## Problem

The Hamming distance between two integers is the number of positions at which the corresponding bits are different.

Given an integer array `nums`, return the sum of Hamming distances between all pairs of the integers in the array.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/total_hamming_distance.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]): Array of integers to calculate Hamming distances from
- **Output:** 
  - Total Hamming distance (int): Sum of Hamming distances between all pairs

## Explanation

Since the list can be large, we use an optimized bit manipulation approach:

For each bit position (0-30 for 32-bit integers):
1. Count how many numbers have that bit set (`count_ones`)
2. The remaining numbers have that bit unset: `count_zeros = n - count_ones`
3. Each pair of (one, zero) contributes 1 to the total Hamming distance at this bit position
4. Total contribution from this bit: `count_ones * count_zeros`

Sum contributions across all bit positions to get the total Hamming distance.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[4, 14, 2]` | `6` | Hamming(4,14)=3, Hamming(4,2)=2, Hamming(14,2)=3; Total=6 |
| `[1, 2, 3]` | `4` | Hamming(1,2)=2, Hamming(1,3)=1, Hamming(2,3)=1; Total=4 |
| `[]` | `0` | Empty array has no pairs |
| `[5]` | `0` | Single element has no pairs |
| `[0, 0, 0]` | `0` | All zeros have Hamming distance 0 |

### Bit Breakdown for `[4, 14, 2]`

| Number | Binary (4 bits) |
|--------|-----------------|
| 4      | 0100            |
| 14     | 1110            |
| 2      | 0010            |

- Bit 0: [0,0,0] → 0 ones × 3 zeros = 0
- Bit 1: [0,1,1] → 2 ones × 1 zero = 2  
- Bit 2: [1,1,0] → 2 ones × 1 zero = 2
- Bit 3: [0,1,0] → 1 one × 2 zeros = 2

**Total: 0 + 2 + 2 + 2 = 6**
