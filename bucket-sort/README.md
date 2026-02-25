# Bucket Sort

## Problem
Implement the **Bucket Sort** algorithm to sort an array of decimal numbers (floating-point values between 0 and 1).

Bucket sort is a distribution-based sorting algorithm that works by:
1. Creating a fixed number of empty buckets
2. Distributing the input elements into these buckets based on their values
3. Sorting each bucket individually (using insertion sort in this implementation)
4. Concatenating all sorted buckets to produce the final sorted array

This algorithm is particularly efficient when the input is uniformly distributed over a range.

## Structure
- **Run Job (`run.xs`):** Calls the test function which runs multiple test cases
- **Function (`function/bucket-sort.xs`):** Contains the bucket sort algorithm implementation
- **Test Function (`function/run-bucket-sort-tests.xs`):** Runs 7 different test cases and returns all results

## Function Signature
- **Input:**
  - `numbers` (decimal[]): Array of decimal numbers to sort (typically values between 0 and 1)
  - `bucket_count` (int, optional, default: 10): Number of buckets to use for distribution
- **Output:**
  - Returns a decimal[] containing the sorted array in ascending order

## Test Cases

| Input | Bucket Count | Expected Output |
|-------|-------------|-----------------|
| `[0.78, 0.17, 0.39, 0.26, 0.72, 0.94, 0.21, 0.12, 0.23, 0.68]` | 5 | `[0.12, 0.17, 0.21, 0.23, 0.26, 0.39, 0.68, 0.72, 0.78, 0.94]` |
| `[0.1, 0.2, 0.3, 0.4, 0.5]` | 3 | `[0.1, 0.2, 0.3, 0.4, 0.5]` |
| `[0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1]` | 5 | `[0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]` |
| `[]` | 5 | `[]` |
| `[0.5]` | 3 | `[0.5]` |
| `[0.5, 0.5, 0.5, 0.5, 0.5]` | 4 | `[0.5, 0.5, 0.5, 0.5, 0.5]` |
| `[0.01, 0.99, 0.5, 0.25, 0.75]` | 10 (default) | `[0.01, 0.25, 0.5, 0.75, 0.99]` |

### Test Case Categories:
- **Basic/Happy Path:** Test cases 1-3 cover standard unsorted, pre-sorted, and reverse-sorted arrays
- **Edge Cases:** Test cases 4-6 cover empty arrays, single elements, and arrays with duplicate values
- **Boundary/Interesting:** Test case 7 uses the default bucket count and tests a wide value range

## Algorithm Complexity
- **Time Complexity:** O(n + k) average case where n is the number of elements and k is the number of buckets. Worst case is O(n²) when all elements fall into one bucket.
- **Space Complexity:** O(n + k) for the buckets and output array

## Notes
- The implementation handles edge cases where all elements are identical
- When a value equals the maximum, it is placed in the last bucket to avoid index out of bounds
- Each bucket is sorted using insertion sort
