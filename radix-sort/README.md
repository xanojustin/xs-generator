# Radix Sort

## Problem
Implement the radix sort algorithm to sort an array of non-negative integers in ascending order.

Radix sort is a non-comparative sorting algorithm that sorts numbers digit by digit, starting from the least significant digit (LSD) to the most significant digit. It uses counting sort (or bucket sort) as a subroutine to sort the digits at each position.

### Algorithm Overview
1. Find the maximum number in the array to determine the number of digits
2. For each digit position (1s, 10s, 100s, etc.):
   - Create 10 buckets (0-9)
   - Distribute each number into a bucket based on the current digit
   - Collect numbers from buckets back into the array in order
3. After processing all digit positions, the array is sorted

## Structure
- **Run Job (`run.xs`):** Calls the radix_sort function with test inputs
- **Function (`function/radix_sort.xs`):** Contains the radix sort implementation

## Function Signature
- **Input:**
  - `numbers` (int[]): An array of non-negative integers to sort
- **Output:** 
  - `int[]`: The sorted array in ascending order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[170, 45, 75, 90, 2, 802, 24, 66]` | `[2, 24, 45, 66, 75, 90, 170, 802]` |
| `[5, 3, 8, 1, 9]` | `[1, 3, 5, 8, 9]` |
| `[]` | `[]` |
| `[42]` | `[42]` |
| `[1000, 1, 100, 10]` | `[1, 10, 100, 1000]` |
| `[0, 0, 0]` | `[0, 0, 0]` |
| `[9, 8, 7, 6, 5, 4, 3, 2, 1, 0]` | `[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]` |

### Notes
- This implementation handles empty arrays and single-element arrays as edge cases
- All numbers must be non-negative integers
- The algorithm has O(d × (n + k)) time complexity where d is the number of digits, n is the number of elements, and k is the range of digit values (10 for decimal)
