# Top K Frequent Elements

## Problem
Given an integer array `nums` and an integer `k`, return the `k` most frequent elements. You may return the answer in any order.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/top_k_frequent.xs`):** Contains the solution logic using a frequency map and sorting

## Function Signature
- **Input:** 
  - `nums` (int[]): An array of integers
  - `k` (int): The number of most frequent elements to return
- **Output:** 
  - Returns int[]: An array containing the `k` most frequent elements

## Approach
1. Build a frequency map counting occurrences of each number
2. Convert the frequency map to a sortable list of objects
3. Sort the list by frequency in descending order using bubble sort
4. Extract the top `k` elements from the sorted list

## Test Cases
| Input | Expected Output |
|-------|-----------------|
| `nums: [1, 1, 1, 2, 2, 3], k: 2` | `[1, 2]` |
| `nums: [1], k: 1` | `[1]` |
| `nums: [1, 1, 2, 2, 3, 3, 3], k: 1` | `[3]` |
| `nums: [4, 4, 4, 4, 5, 5, 6, 6, 6], k: 2` | `[4, 6]` or `[6, 4]` |

## Complexity
- **Time:** O(n²) where n is the number of unique elements (bubble sort for simplicity)
- **Space:** O(n) for storing the frequency map
