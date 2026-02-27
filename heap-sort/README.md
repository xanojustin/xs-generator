# Heap Sort

## Problem

Sort an array of integers in ascending order using the **Heap Sort** algorithm.

Heap Sort is a comparison-based sorting algorithm that uses a binary heap data structure. It works by:
1. Building a max heap from the input data (where the parent node is always larger than its children)
2. Repeatedly extracting the maximum element from the heap and placing it at the end
3. Maintaining the heap property after each extraction

**Time Complexity:** O(n log n) for all cases (best, average, worst)
**Space Complexity:** O(1) auxiliary space (sorts in-place)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/heap_sort.xs`):** Contains the heap sort implementation

## Function Signature

- **Input:** 
  - `numbers` (int[]): Array of integers to sort
- **Output:** 
  - Sorted array of integers in ascending order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[64, 34, 25, 12, 22, 11, 90]` | `[11, 12, 22, 25, 34, 64, 90]` |
| `[5, 2, 8, 1, 9]` | `[1, 2, 5, 8, 9]` |
| `[]` | `[]` |
| `[42]` | `[42]` |
| `[3, 3, 3]` | `[3, 3, 3]` |
| `[5, 4, 3, 2, 1]` | `[1, 2, 3, 4, 5]` (reverse sorted) |

### Test Case Descriptions

1. **Basic case:** Typical unsorted array with multiple elements
2. **Small array:** Simple case with distinct values
3. **Edge case (empty):** Empty array should return empty
4. **Edge case (single):** Single element array is already sorted
5. **Edge case (duplicates):** Array with all identical elements
6. **Boundary case:** Reverse-sorted array (worst-case scenario for some algorithms)

## Algorithm Explanation

### Max Heap
A max heap is a complete binary tree where each parent node is greater than or equal to its children. The root of a max heap is always the maximum element.

### Build Heap
Starting from the last non-leaf node (at index n/2 - 1), we heapify each node going up to the root. This ensures the entire array satisfies the heap property.

### Heapify
The process of maintaining the heap property by comparing a node with its children and swapping if necessary. If a swap occurs, we recursively heapify the affected subtree.

### Sort Process
1. Build a max heap from the input array
2. Swap the root (maximum element) with the last element
3. Reduce heap size by 1
4. Heapify the root to restore heap property
5. Repeat steps 2-4 until heap size is 1
