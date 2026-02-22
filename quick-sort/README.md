# Quick Sort

## Problem
Implement the Quick Sort algorithm to sort an array of integers in ascending order.

Quick Sort is a divide-and-conquer algorithm that works by:
1. Selecting a 'pivot' element from the array
2. Partitioning the other elements into two sub-arrays according to whether they are less than or greater than the pivot
3. Recursively sorting the sub-arrays
4. Combining the sorted sub-arrays and the pivot back into a single sorted array

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/quick_sort.xs`):** Contains the quicksort implementation

## Function Signature
- **Input:** 
  - `numbers` (int[]): An array of integers to be sorted
- **Output:** 
  - Returns an int[] containing all elements from the input array sorted in ascending order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[64, 34, 25, 12, 22, 11, 90, 5, 77, 43]` | `[5, 11, 12, 22, 25, 34, 43, 64, 77, 90]` |
| `[3, -1, 0, 5, -2]` | `[-2, -1, 0, 3, 5]` |
| `[]` | `[]` |
| `[42]` | `[42]` |
| `[5, 5, 5, 5]` | `[5, 5, 5, 5]` |
| `[1, 2, 3, 4, 5]` | `[1, 2, 3, 4, 5]` |
| `[5, 4, 3, 2, 1]` | `[1, 2, 3, 4, 5]` |

### Test Case Descriptions
1. **Standard unsorted array:** A typical case with mixed values
2. **Array with negative numbers:** Tests handling of negative integers
3. **Empty array:** Edge case - should return empty array
4. **Single element:** Edge case - already sorted by definition
5. **All same elements:** Tests stability with duplicate values
6. **Already sorted:** Tests behavior on already-sorted input
7. **Reverse sorted:** Tests behavior on reverse-sorted input

## Algorithm Complexity
- **Time Complexity:** 
  - Average case: O(n log n)
  - Worst case: O(n²) when the array is already sorted and we always pick the last element as pivot
- **Space Complexity:** O(log n) due to recursive call stack

## Notes
- This implementation uses the last element as the pivot
- The algorithm is not stable (equal elements may change relative order)
- For production use with large datasets, consider using a randomized pivot or median-of-three strategy to avoid worst-case performance
