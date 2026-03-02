# Queue Reconstruction by Height

## Problem

You are given an array of people, where each person is represented as `[hi, ki]`:
- `hi` is the height of person `i`
- `ki` is the number of people in front of person `i` who have a height greater than or equal to `hi`

Reconstruct and return the queue that matches the given conditions. The queue should be represented as an array where each element is `[hi, ki]`.

### Example
Input: `[[7,0], [4,4], [7,1], [5,0], [6,1], [5,2]]`
Output: `[[5,0], [7,0], [5,2], [6,1], [4,4], [7,1]]`

### Explanation
- Person with height 5 and k=0 should have 0 people in front taller/equal → position 0
- Person with height 7 and k=0 should have 0 people in front taller/equal → position 1
- Person with height 5 and k=2 should have 2 people in front taller/equal → position 2
- Person with height 6 and k=1 should have 1 person in front taller/equal → position 3
- Person with height 4 and k=4 should have 4 people in front taller/equal → position 4
- Person with height 7 and k=1 should have 1 person in front taller/equal → position 5

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/queue_reconstruction.xs`):** Contains the solution logic using a greedy approach

## Function Signature

- **Input:** 
  - `people` (json): Array of [height, k] pairs
- **Output:** 
  - Array of [height, k] pairs representing the reconstructed queue

## Algorithm

The solution uses a greedy approach:

1. **Sort** people by height descending, then by k ascending
   - Tallest people first (they don't care about shorter people in front)
   - For same height, smaller k comes first

2. **Insert** each person at position k in the result
   - Since we process tallest first, inserting at position k guarantees exactly k taller/equal people in front

## Time & Space Complexity

- **Time Complexity:** O(n²) due to bubble sort for custom ordering and array insertion
- **Space Complexity:** O(n) for storing sorted indices and result

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[7,0], [4,4], [7,1], [5,0], [6,1], [5,2]]` | `[[5,0], [7,0], [5,2], [6,1], [4,4], [7,1]]` |
| `[[6,0], [5,0], [4,0], [3,2], [2,2], [1,4]]` | `[[4,0], [5,0], [2,2], [3,2], [1,4], [6,0]]` |
| `[]` | `[]` |
| `[[1,0]]` | `[[1,0]]` |

### Test Case Explanations

1. **Basic case:** Standard example with multiple people of varying heights
2. **All different heights:** Tests the greedy approach with strictly decreasing heights
3. **Empty input:** Edge case - empty array should return empty array
4. **Single person:** Edge case - single person with k=0
