# Duplicate Zeros

## Problem
Given a fixed-length array of integers, duplicate each occurrence of zero, shifting the remaining elements to the right. Note that elements beyond the length of the original array are not written. The operation should be done as if modifying the input array in place.

**Example:**
- Input: `[1, 0, 2, 3, 0, 4, 5, 0]`
- Output: `[1, 0, 0, 2, 3, 0, 0, 4]`

Explanation: The zeros at indices 1 and 4 are duplicated. The zero at index 7 would be duplicated but the result would extend beyond the array length, so it's truncated.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/duplicate_zeros.xs`):** Contains the solution logic using a backwards traversal approach

## Function Signature
- **Input:** 
  - `arr` (int[]): Array of integers to process
- **Output:** 
  - int[]: Modified array with zeros duplicated (same length as input)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 0, 2, 3, 0, 4, 5, 0]` | `[1, 0, 0, 2, 3, 0, 0, 4]` |
| `[0, 0, 0]` | `[0, 0, 0]` (only fits 3 zeros) |
| `[1, 2, 3]` | `[1, 2, 3]` (no zeros to duplicate) |
| `[0]` | `[0]` (single zero stays as is) |
| `[1, 5, 0, 2]` | `[1, 5, 0, 0]` |

### Test Case Explanations:
1. **Basic case:** Multiple zeros, some duplication fits, some gets truncated
2. **All zeros:** Edge case - all elements are zeros, array length is preserved
3. **No zeros:** Edge case - input has no zeros, output matches input
4. **Single element zero:** Boundary case - minimal array with zero
5. **Zero at end:** Boundary case - zero at second-to-last position gets duplicated
