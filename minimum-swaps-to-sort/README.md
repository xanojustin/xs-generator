# Minimum Swaps to Sort

## Problem
Given an array of integers, find the minimum number of swaps required to sort the array in ascending order.

A swap is defined as exchanging two elements in the array. The goal is to determine the minimum number of such exchanges needed to sort the entire array.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/minimum_swaps_to_sort.xs`):** Contains the solution logic using cycle detection

## Function Signature
- **Input:** 
  - `arr` (int[]): Array of integers to be sorted
- **Output:** 
  - Returns (int): Minimum number of swaps required to sort the array

## Approach
This solution uses a **cycle detection** algorithm:
1. Create pairs of (value, original_index) for each element
2. Sort these pairs by value to know where each element should go
3. Track visited elements to avoid counting cycles twice
4. For each unvisited element, trace its cycle (elements that need to swap with each other)
5. Each cycle of size N requires N-1 swaps
6. Sum all swaps from all cycles

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[4, 3, 2, 1]` | 2 | Swap 4↔1, then 3↔2 (or similar) |
| `[1, 2, 3, 4]` | 0 | Already sorted, no swaps needed |
| `[2, 1]` | 1 | Single swap needed |
| `[1]` | 0 | Single element, already sorted |
| `[]` | 0 | Empty array, no swaps needed |
| `[7, 1, 3, 2, 4, 5, 6]` | 5 | Multiple cycles requiring 5 total swaps |
| `[2, 3, 4, 1, 5]` | 3 | One cycle of 4 elements (4-1=3 swaps) |

## Example Walkthrough

For input `[4, 3, 2, 1]`:
1. Create pairs: `[(4,0), (3,1), (2,2), (1,3)]`
2. Sort by value: `[(1,3), (2,2), (3,1), (4,0)]`
3. Detect cycles:
   - Element at index 0 (value 4) should go to index 3
   - Element at index 3 (value 1) should go to index 0
   - This forms a cycle: 0 → 3 → 0 (size 2, needs 1 swap)
   - Element at index 1 (value 3) should go to index 2
   - Element at index 2 (value 2) should go to index 1
   - This forms a cycle: 1 → 2 → 1 (size 2, needs 1 swap)
4. Total swaps: 1 + 1 = **2**
