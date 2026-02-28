# Chunk Array

## Problem

Given an array and a chunk size, divide the array into subarrays (chunks) where each subarray has at most `size` elements. The last chunk may contain fewer than `size` elements if there aren't enough elements remaining.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/chunk_array.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `array` (int[]): The input array to be chunked
  - `size` (int): The maximum size of each chunk (must be at least 1)
- **Output:** (int[][]): An array of chunks, where each chunk is an array of integers

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 3, 4, 5]`, size `2` | `[[1, 2], [3, 4], [5]]` |
| `[1, 2, 3, 4, 5, 6, 7, 8]`, size `3` | `[[1, 2, 3], [4, 5, 6], [7, 8]]` |
| `[]`, size `3` | `[]` |
| `[1]`, size `2` | `[[1]]` |
| `[1, 2, 3]`, size `1` | `[[1], [2], [3]]` |

## Example

```
Input: array = [1, 2, 3, 4, 5], size = 2
Output: [[1, 2], [3, 4], [5]]

Explanation: The array is split into chunks of size 2.
- First chunk: [1, 2]
- Second chunk: [3, 4]
- Third chunk: [5] (only 1 element remaining)
```
