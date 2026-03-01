# Sum of Even Numbers After Queries

## Problem

You are given an integer array `nums` and a 2D array `queries` where `queries[i] = [vali, indexi]`.

For each query `i`, first apply `nums[indexi] += vali`, then return the sum of all even numbers in `nums`.

Return an integer array `answer` where `answer[i]` is the answer to the `i`-th query.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sum_evens_after_queries.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `nums` (int[]): The initial integer array
  - `queries` (object[]): Array of query objects, each with:
    - `val` (int): The value to add
    - `index` (int): The index in nums to modify
  
- **Output:** 
  - `int[]`: An array where each element is the sum of even numbers after applying the corresponding query

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums: [1,2,3,4]`, `queries: [[1,0],[-3,1],[-4,0],[2,3]]` | `[8,6,2,4]` |
| `nums: [1]`, `queries: [[4,0]]` | `[0]` |
| `nums: [0]`, `queries: [[1,0],[2,0]]` | `[2,4]` |
| `nums: [5,5,5]`, `queries: [[1,0],[1,1],[1,2]]` | `[0,0,0]` |

### Explanation of Test Case 1:
1. After 1st query: `nums = [2,2,3,4]`, even sum = `2+2+4 = 8`
2. After 2nd query: `nums = [2,-1,3,4]`, even sum = `2+4 = 6`
3. After 3rd query: `nums = [-2,-1,3,4]`, even sum = `-2+4 = 2`
4. After 4th query: `nums = [-2,-1,3,6]`, even sum = `-2+6 = 4`

## Constraints

- `1 <= nums.length <= 10^4`
- `-10^4 <= nums[i] <= 10^4`
- `1 <= queries.length <= 10^4`
- `-10^4 <= val <= 10^4`
- `0 <= index < nums.length`
