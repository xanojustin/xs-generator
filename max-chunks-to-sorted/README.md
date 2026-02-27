# Max Chunks To Sorted

## Problem

Given an array `arr` that is a permutation of `[0, 1, ..., arr.length - 1]`, we split the array into some number of "chunks" (partitions), and individually sort each chunk. After concatenating them, the result equals the sorted array.

What is the most number of chunks we could have made?

### Key Insight
We can form a chunk ending at index `i` when the maximum value we've seen so far equals `i`. This works because in a sorted permutation, element `i` should be at position `i`, so if the max of elements `0..i` is exactly `i`, those elements can be sorted to fill positions `0..i`.

## Structure

- **Run Job (`run.xs`):** Calls the `max_chunks` function with test inputs
- **Function (`function/max_chunks.xs`):** Contains the solution logic using a single pass through the array

## Function Signature

- **Input:** 
  - `arr` (int[]): A permutation of `[0, 1, ..., n-1]`
- **Output:** 
  - `int`: The maximum number of chunks that can be formed

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 0, 2, 3, 4]` | 4 | Can split at indices 1, 2, 3, 4: [1,0], [2], [3], [4] |
| `[4, 3, 2, 1, 0]` | 1 | Must sort entire array as one chunk |
| `[0]` | 1 | Single element is already one chunk |
| `[0, 1, 2, 3, 4]` | 5 | Already sorted, each element is its own chunk |
| `[2, 0, 1]` | 1 | The max at index 2 is 2, so only one chunk |

### Algorithm
1. Initialize `chunks = 0` and `max_so_far = -1`
2. Iterate through the array with index `i`
3. Update `max_so_far` with the maximum value seen
4. If `max_so_far == i`, increment `chunks` (we can form a chunk ending here)
5. Return `chunks`
